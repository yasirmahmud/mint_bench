module mem_ctrl #(
    parameter int ADDR_WIDTH = 8,
    parameter int DATA_WIDTH = 32
) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      req_valid,
    input  logic                      req_write,
    input  logic [ADDR_WIDTH-1:0]     req_addr,
    input  logic [DATA_WIDTH-1:0]     req_wdata,
    input  logic [DATA_WIDTH/8-1:0]   req_be,
    output logic                      req_ready,
    output logic                      resp_valid,
    output logic [DATA_WIDTH-1:0]     resp_rdata,
    input  logic                      resp_ready,
    output logic                      busy,
    output logic                      err
);

localparam int BE_WIDTH = DATA_WIDTH/8;
localparam int DEPTH = (1<<ADDR_WIDTH)

typedef enum logic [1:0] {S_IDLE, S_READ, S_WRITE, S_RESP} state_e;

logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

state_e state_q, state_d;

logic [ADDR_WIDTH-1:0] addr_q, addr_d;
logic [DATA_WIDTH-1:0] wr_data_q, wr_data_d;
logic [BE_WIDTH-1:0]   be_q, be_d;
logic                  rd_en_q, rd_en_d;
logic                  wr_en_q, wr_en_d;
logic                  resp_valid_q, resp_valid_d;
logic [DATA_WIDTH-1:0] rd_data_q;
logic                  err_q, err_d;

function automatic [DATA_WIDTH-1:0] apply_be(
    input [DATA_WIDTH-1:0] old_d,
    input [DATA_WIDTH-1:0] new_d,
    input [BE_WIDTH-1:0]   be_d_f
);
    automatic logic [DATA_WIDTH-1:0] masked;
    masked = old_d;
    for (int i = 0; i < BE_WIDTH; i++) begin
        if (be_d_f[i]) begin
            masked[i*8 +: 8] = new_d[i*8 +: 8];
        end
    end
    return masked;
endfunction

always_comb begin
    state_d       = state_q;
    addr_d        = addr_q;
    wr_data_d     = wr_data_q;
    be_d          = be_q;
    rd_en_d       = 1'b0;
    wr_en_d       = 1'b0;
    resp_valid_d  = 1'b0;
    err_d         = 1'b0;
    req_ready     = 1'b0;

    case (state_q)
        S_IDLE: begin
            req_ready = 1'b1;
            if (req_valid) begin
                addr_d    = req_addr;
                be_d      = req_be;
                wr_data_d = req_wdata;
                if (req_write) begin
                    wr_en_d  = 1'b1;
                    state_d  = S_WRITE;
                    resp_valid_d = 1'b1;
                end else begin
                    rd_en_d  = 1'b1;
                    state_d  = S_READ;
                    resp_valid_d = 1'b1;
                end
            end
        end
        S_READ: begin
            rd_en_d      = 1'b1;
            state_d      = S_RESP;
            resp_valid_d = 1'b1;
        end
        S_WRITE: begin
            wr_en_d      = 1'b1;
            state_d      = S_RESP;
            resp_valid_d = 1'b1;
        end
        S_RESP: begin
            if (resp_ready) begin
                state_d      = S_IDLE;
                resp_valid_d = 1'b0;
            end else begin
                resp_valid_d = 1'b1;
            end
        end
        default: begin
            state_d = S_IDLE;
        end
    endcase
end

assign busy       = (state_q != S_IDLE);
assign resp_valid = resp_valid_q;
assign resp_rdata = rd_data_q;
assign err        = err_q;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state_q      <= S_IDLE;
        addr_q       <= '0;
        wr_en_q      <= 1'b0;
        rd_en_q      <= 1'b0;
        wr_data_q    <= '0;
        be_q         <= '0;
        rd_data_q    <= '0;
        resp_valid_q <= 1'b0;
        err_q        <= 1'b0;
    end else begin
        state_q      <= state_d;
        addr_q       <= addr_d;
        wr_en_q      <= wr_en_d;
        rd_en_q      <= rd_en_d;
        wr_data_q    =  wr_data_d;
        be_q         <= be_d;
        resp_valid_q <= resp_valid_d;
        err_q        <= err_d;
        if (wr_en_d) begin
            mem[addr_d] <= apply_be(mem[addr_d], wr_data_d, be_d);
        end
        if (rd_en_d) begin
            rd_data_q <= mem[addr_d];
        end
    end
end

endmodule