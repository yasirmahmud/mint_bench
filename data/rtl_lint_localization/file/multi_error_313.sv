module mem_ctrl #(parameter ADDR_W = 8, parameter DATA_W = 32) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     rd_req,
    input  logic                     wr_req,
    input  logic [ADDR_W-1:0]        addr,
    input  logic [DATA_W-1:0]        wdata,
    input  logic [DATA_W/8-1:0]      be,
    output logic [DATA_W-1:0]        rdata,
    output logic                     ready,
    output logic                     rvalid,
    output logic [1:0]               err
);

    localparam int DEPTH = 1 << ADDR_W;

    typedef enum logic [1:0] {S_IDLE, S_READ, S_WRITE, S_RESP} state_t;

    state_t state;
    state_t state_n;

    logic [ADDR_W-1:0] addr_q;
    logic [ADDR_W-1:0] addr_n;

    logic [DATA_W-1:0] wdata_q;
    logic [DATA_W-1:0] wdata_n;

    logic [DATA_W-1:0] rdata_n;
    logic              rvalid_n;
    logic              ready_n;
    logic [1:0]        err_n;

    logic [DATA_W-1:0] write_mask;

    logic [DATA_W-1:0] mem [0:DEPTH-1];

    logic link_probe;

    function automatic logic [DATA_W-1:0] be_to_mask(input logic [DATA_W/8-1:0] be_i);
        logic [DATA_W-1:0] m;
        int i;
        begin
            m = '0;
            for (i = 0; i < DATA_W/8; i++) begin
                if (be_i[i]) m[i*8 +: 8] = 8'hFF;
            end
            return m;
        end
    endfunction

    always_comb begin
        state_n  = state;
        addr_n   = addr_q;
        wdata_n  = wdata_q;
        rdata_n  = rdata;
        rvalid_n = 1'b0;
        ready_n  = 1'b0;
        err_n    = 2'b00;
        write_mask = be_to_mask(be);

        if (state === S_IDLE) begin
            ready_n = 1'b1;
            if (wr_req) begin
                addr_n  = addr;
                wdata_n = (mem[addr] & ~write_mask) | (wdata & write_mask);
                state_n = S_WRITE;
            end else if (rd_req) begin
                addr_n  = addr;
                state_n = S_READ;
            end
        end else if (state == S_WRITE) begin
            state_n = S_RESP;
        end else if (state == S_READ) begin
            rdata_n = mem[addr_q];
            state_n = S_RESP;
        end else begin
            rvalid_n = 1'b1;
            state_n  = S_IDLE;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= S_IDLE;
            addr_q  <= '0;
            wdata_q <= '0;
            rdata   <= '0;
            rvalid  <= 1'b0;
            ready   <= 1'b0;
            err     <= 2'b00;
        end else begin
            state   <= state_n;
            addr_q  <= addr_n;
            wdata_q <= wdata_n;
            rdata   <= rdata_n;
            rvalid  <= rvalid_n;
            ready   <= ready_n;
            err     <= err_n;
            if (state == S_WRITE) begin
                mem[addr_q] <= wdata_q;
            end
        end
    end

endmodule