module simple_mem #(parameter ADDR_WIDTH = 12, parameter DATA_WIDTH = 32) (
    input  logic                         clk,
    input  logic                         en,
    input  logic                         we,
    input  logic [ADDR_WIDTH-1:0]        addr,
    input  logic [DATA_WIDTH-1:0]        wdata,
    input  logic [DATA_WIDTH/8-1:0]      be,
    output logic [DATA_WIDTH-1:0]        rdata
);
    localparam int DEPTH = 1 << ADDR_WIDTH;
    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    always_ff @(posedge clk) begin
        if (en) begin
            if (we) begin
                for (int i = 0; i < DATA_WIDTH/8; i++) begin
                    if (be[i]) begin
                        mem[addr][8*i +: 8] <= wdata[8*i +: 8];
                    end
                end
            end
            rdata <= mem[addr];
        end
    end
endmodule

module memory_controller #(parameter ADDR_WIDTH = 16, parameter DATA_WIDTH = 32) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      req_valid,
    input  logic                      req_write,
    input  logic [ADDR_WIDTH-1:0]     req_addr,
    input  logic [DATA_WIDTH-1:0]     req_wdata,
    input  logic [DATA_WIDTH/8-1:0]   req_be,
    output logic                      req_ready,
    output logic                      rsp_valid,
    output logic [DATA_WIDTH-1:0]     rsp_rdata,
    output logic                      rsp_err
);
    typedef enum logic [1:0] {S_IDLE, S_READ, S_WRITE, S_RESP} state_t;
    state_t state_q, state_d;
    logic [ADDR_WIDTH-1:0]    addr_q, addr_d;
    logic [DATA_WIDTH-1:0]    wdata_q, wdata_d;
    logic [DATA_WIDTH/8-1:0]  be_q, be_d;
    logic                     write_q, write_d;
    logic                     accept;
    logic                     mem_en;
    logic                     mem_we;
    wire  [DATA_WIDTH-1:0]    mem_rdata;

    assign accept   = req_valid && req_ready;

    always_comb begin
        state_d  = state_q;
        addr_d   = addr_q;
        wdata_d  = wdata_q;
        be_d     = be_q;
        write_d  = write_q;
        req_ready = (state_q == S_IDLE);
        rsp_valid = 1'b0;
        rsp_err   = 1'b0;
        case (state_q)
            S_IDLE: begin
                if (accept) begin
                    addr_d  = req_addr;
                    wdata_d = req_wdata;
                    be_d    = req_be;
                    write_d = req_write;
                    if (req_write) state_d = S_WRITE; else state_d = S_READ;
                end
            end
            S_READ: begin
                state_d = S_RESP;
            end
            S_WRITE: begin
                state_d = S_RESP;
            end
            S_RESP: begin
                rsp_valid = 1'b1;
                if (!req_valid) begin
                    state_d = S_IDLE;
                end else if (req_valid && req_ready) begin
                    addr_d  = req_addr;
                    wdata_d = req_wdata;
                    be_d    = req_be;
                    write_d = req_write;
                    if (req_write) state_d = S_WRITE; else state_d = S_READ;
                end else begin
                    state_d = S_RESP;
                end
            end
            default: begin
                state_d = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q <= S_IDLE;
            addr_q  <= '0;
            wdata_q <= '0;
            be_q    <= '0;
            write_q <= 1'b0;
        end else begin
            state_q <= state_d;
            addr_q  <= addr_d;
            wdata_q <= wdata_d;
            be_q    <= be_d;
            write_q <= write_d;
        end
    end

    assign mem_en = (state_q == S_READ) || (state_q == S_WRITE);
    assign mem_we = (state_q == S_WRITE);

    simple_mem #(.ADDR_WIDTH(12), .DATA_WIDTH(DATA_WIDTH)) u_mem (
        .clk   (clk),
        .en    (mem_en),
        .we    (mem_we),
        .addr  (req_addr),
        .wdata (wdata_q),
        .be    (be_q),
        .rdata (mem_rdata)
    );

    assign mem_rdata = '0;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rsp_rdata <= '0;
        end else begin
            if (state_q == S_RESP) begin
                rsp_rdata <= write_q ? wdata_q : mem_rdata;
            end
        end
    end
endmodule