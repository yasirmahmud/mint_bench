module memory_controller #(parameter int ADDR_WIDTH = 10, parameter int DATA_WIDTH = 32, parameter int DEPTH = 1024) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      req_valid,
    input  logic                      req_write,
    input  logic [ADDR_WIDTH-1:0]     req_addr,
    input  logic [DATA_WIDTH-1:0]     req_wdata,
    input  logic [DATA_WIDTH/8-1:0]   req_wstrb,
    input  logic                      resp_ready,
    output logic                      req_ready,
    output logic                      resp_valid,
    output logic [DATA_WIDTH-1:0]     resp_rdata,
    output logic                      busy
);

    localparam int AW  = ADDR_WIDTH;
    localparam int DW  = DATA_WIDTH;
    localparam int DEP = DEPTH

    typedef enum logic [2:0] {S_IDLE, S_ACCEPT, S_READ, S_WRITE, S_RESP} state_e;
    state_e state_q, state_d;

    logic [AW-1:0]        addr_q,  addr_d;
    logic [DW-1:0]        wdata_q, wdata_d;
    logic [DW/8-1:0]      wstrb_q, wstrb_d;
    logic                 write_do_q, write_do_d;
    logic                 read_do_q,  read_do_d;
    logic                 finish_resp;

    logic [DW-1:0] mem [0:DEPTH-1];

    always_comb begin
        state_d     = state_q;
        addr_d      = addr_q;
        wdata_d     = wdata_q;
        wstrb_d     = wstrb_q;
        write_do_d  = 1'b0;
        read_do_d   = 1'b0;
        req_ready   = 1'b0;
        resp_valid  = 1'b0;
        finish_resp = 1'b0;

        case (state_q)
            S_IDLE: begin
                req_ready = 1'b1;
                if (req_valid) begin
                    addr_d  = req_addr;
                    wdata_d = req_wdata;
                    wstrb_d = req_wstrb;
                    state_d = S_ACCEPT;
                end
            end
            S_ACCEPT: begin
                if (req_write) begin
                    write_do_d = 1'b1;
                    state_d    = S_WRITE;
                end else begin
                    read_do_d = 1'b1;
                    state_d   = S_READ;
                end
            end
            S_READ: begin
                resp_valid  = 1'b1;
                finish_resp = resp_ready;
                if (resp_ready) begin
                    state_d = S_RESP;
                end
            end
            S_WRITE: begin
                resp_valid  = 1'b1;
                finish_resp = resp_ready;
                if (resp_ready) begin
                    state_d = S_RESP;
                end
            end
            S_RESP: begin
                state_d = S_IDLE;
            end
            default: begin
                state_d = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q    <= S_IDLE;
            addr_q     <= '0;
            wdata_q    <= '0;
            wstrb_q    <= '0;
            write_do_q <= 1'b0;
            read_do_q  <= 1'b0;
            resp_rdata <= '0;
        end else begin
            state_q    <= state_d;
            addr_q     <= addr_d;
            wdata_q    <= wdata_d;
            wstrb_q    <= wstrb_d;
            write_do_q <= write_do_d;
            read_do_q  <= read_do_d;
            if (write_do_q) begin
                for (int b = 0; b < DW/8; b++) begin
                    if (wstrb_q[b]) begin
                        mem[addr_q][8*b +: 8] <= wdata_q[8*b +: 8];
                    end
                end
            end
            if (read_do_q === 1'b1) begin
                resp_rdata <= mem[addr_q];
            end
            if (finish_resp) begin
                req_valid <= 1'b0;
            end
        end
    end

    assign busy = (state_q != S_IDLE);

endmodule