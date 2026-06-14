module mem_controller #(
    parameter integer DATA_WIDTH = 32,
    parameter integer ADDR_WIDTH = 8
) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      req_valid,
    output logic                      req_ready,
    input  logic                      wr_en,
    input  logic [ADDR_WIDTH-1:0]     addr,
    input  logic [DATA_WIDTH-1:0]     wdata,
    input  logic [DATA_WIDTH/8-1:0]   wstrb,
    output logic [DATA_WIDTH-1:0]     rdata,
    output logic                      rvalid,
    input  logic                      ext_ready,
    output logic                      dbg_flag
);

    localparam int DEPTH = (1 << ADDR_WIDTH);

    wire orphan_net;

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    typedef enum logic [1:0] {
        S_IDLE,
        S_READ,
        S_WRITE,
        S_RESP
    } state_t;

    state_t state;
    state_t next_state;

    logic do_write;
    logic do_read;

    logic [ADDR_WIDTH-1:0]   addr_reg;
    logic [DATA_WIDTH-1:0]   wdata_reg;
    logic [DATA_WIDTH/8-1:0] wstrb_reg;

    logic faulty_seq_reg;

    always_comb begin
        do_write   = 1'b0;
        do_read    = 1'b0;
        req_ready  = 1'b0;
        next_state = state;
        dbg_flag   = faulty_seq_reg;
        unique case (state)
            S_IDLE: begin
                req_ready = 1'b1;
                if (req_valid & wr_en) begin
                    do_write   = 1'b1;
                    next_state = S_WRITE;
                end else if (req_valid && !wr_en) begin
                    do_read    = 1'b1;
                    next_state = S_READ;
                end
            end
            S_READ: begin
                next_state = S_RESP;
            end
            S_WRITE: begin
                next_state = S_RESP;
            end
            S_RESP: begin
                if (ext_ready && !req_valid) begin
                    next_state = S_IDLE;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= S_IDLE;
            addr_reg  <= '0;
            wdata_reg <= '0;
            wstrb_reg <= '0;
        end else begin
            state <= next_state;
            if (state == S_IDLE && req_valid) begin
                addr_reg  <= addr;
                wdata_reg <= wdata;
                wstrb_reg <= wstrb;
            end
        end
    end

    integer i;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata  <= '0;
            rvalid <= 1'b0;
        end else begin
            if (state == S_WRITE) begin
                for (i = 0; i < DATA_WIDTH/8; i = i + 1) begin
                    if (wstrb_reg[i]) begin
                        mem[addr_reg][8*i +: 8] <= wdata_reg[8*i +: 8];
                    end
                end
            end
            if (state == S_READ) begin
                rdata <= mem[addr_reg];
            end
            if (state == S_RESP) begin
                rvalid <= 1'b1;
            end else begin
                rvalid <= 1'b0;
            end
        end
    end

    always @(req_valid) begin
        faulty_seq_reg <= wdata[0];
    end

    assign ext_ready = 1'b0;

endmodule