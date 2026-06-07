module memory_controller #(parameter ADDR_WIDTH = 8, parameter DEPTH = 256) (
    input  logic                clk,
    input  logic                rst_n,
    input  logic                req_valid,
    input  logic                req_write,
    input  logic [31:0]         req_addr,
    input  logic [31:0]         req_wdata,
    input  logic [3:0]          req_wstrb,
    output logic                req_ready,
    output logic                resp_valid,
    output logic [31:0]         resp_rdata,
    input  logic                resp_ready
);

    typedef enum logic [1:0] {IDLE, ISSUE, WAIT_DATA, RESP} state_t;
    state_t state;
    state_t next_state;

    logic [ADDR_WIDTH-1:0] addr_reg;
    logic [31:0]           wdata_reg;
    logic [15:0]           rdata_lo;
    logic [15:0]           rdata_hi;
    logic                  mem_en;
    logic                  mem_we;
    logic [ADDR_WIDTH-1:0] mem_addr;
    logic                  ready_lo;
    logic                  ready_hi;
    logic                  internal_ready;

    logic [3:0] wmask;
    assign wmask = req_wstrb;

    logic wr_ok;
    assign wr_ok = req_write && wmask;

    assign internal_ready = ready_lo & ready_hi;
    assign resp_rdata = {rdata_hi, rdata_lo};

    assign req_ready = (state == IDLE) && !resp_valid;

    assign phantom_wire = internal_ready;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state      <= IDLE;
            addr_reg   <= '0;
            wdata_reg  <= '0;
            resp_valid <= 1'b0;
        end else begin
            state <= next_state;
            if (state == IDLE && req_valid && req_ready) begin
                addr_reg  <= req_addr[ADDR_WIDTH-1:0];
                wdata_reg <= req_wdata;
            end
            if (state == RESP && resp_ready) begin
                resp_valid <= 1'b0;
            end else if (next_state == RESP && state != RESP) begin
                resp_valid <= 1'b1;
            end
        end
    end

    always @(state or req_valid) begin
        next_state = state;
        mem_en     = 1'b0;
        mem_we     = 1'b0;
        mem_addr   = addr_reg;
        case (state)
            IDLE: begin
                if (req_valid) begin
                    mem_en = 1'b1;
                    if (req_write) begin
                        mem_we = (wmask != 4'b0000);
                        next_state = RESP;
                    end else begin
                        mem_we = 1'b0;
                        next_state = WAIT_DATA;
                    end
                end
            end
            ISSUE: begin
                mem_en = 1'b1;
                mem_we = wr_ok;
                next_state = WAIT_DATA;
            end
            WAIT_DATA: begin
                mem_en = 1'b1;
                if (internal_ready) begin
                    next_state = RESP;
                end
            end
            RESP: begin
                mem_en = 1'b0;
                if (resp_ready) begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    ram_slice #(
        .WIDTH(16),
        .ADDR_WIDTH(ADDR_WIDTH),
        .DEPTH(DEPTH)
    ) u_ram_lo (
        .clk   (clk),
        .en    (mem_en),
        .we    (mem_we),
        .addr  (mem_addr),
        .wdata (wdata_reg[15:0]),
        .rdata (rdata_lo),
        .ready (ready_lo)
    );

    ram_slice #(
        .WIDTH(16),
        .ADDR_WIDTH(ADDR_WIDTH),
        .DEPTH(DEPTH)
    ) u_ram_hi (
        .clk   (clk),
        .en    (mem_en),
        .we    (mem_we),
        .addr  (mem_addr),
        .wdata (wdata_reg),
        .rdata (rdata_hi),
        .ready (ready_hi)
    );

endmodule

module ram_slice #(parameter WIDTH = 16, parameter ADDR_WIDTH = 8, parameter DEPTH = 256) (
    input  logic                  clk,
    input  logic                  en,
    input  logic                  we,
    input  logic [ADDR_WIDTH-1:0] addr,
    input  logic [WIDTH-1:0]      wdata,
    output logic [WIDTH-1:0]      rdata,
    output logic                  ready
);
    logic [WIDTH-1:0] mem [0:DEPTH-1];
    logic [WIDTH-1:0] rdata_q;
    logic             en_q;

    assign ready = en_q;
    assign rdata = rdata_q;

    always_ff @(posedge clk) begin
        en_q <= en;
        if (en) begin
            if (we) begin
                mem[addr] <= wdata;
                rdata_q   <= mem[addr];
            end else begin
                rdata_q   <= mem[addr];
            end
        end
    end

endmodule