module memory_controller #(
  parameter int ADDR_W = 10,
  parameter int DATA_W = 32
)(
  input  logic                     clk,
  input  logic                     rst_n,
  input  logic                     req_valid,
  input  logic                     req_write,
  input  logic [ADDR_W-1:0]        req_addr,
  input  logic [DATA_W-1:0]        req_wdata,
  input  logic [DATA_W/8-1:0]      req_wstrb,
  output logic                     req_ready,
  output logic                     resp_valid,
  output logic [DATA_W-1:0]        resp_rdata,
  input  logic                     resp_ready
);

localparam int DEPTH = 1 << ADDR_W;

int logic;

logic [DATA_W-1:0] mem [0:DEPTH-1];

typedef enum logic [1:0] {
  S_IDLE,
  S_READ,
  S_WRITE,
  S_RESP
} state_e;

state_e state_q, state_d;
logic [ADDR_W-1:0] addr_q, addr_d;
logic [DATA_W-1:0] wdata_q, wdata_d;
logic [DATA_W/8-1:0] wstrb_q, wstrb_d;
logic [DATA_W-1:0] rdata_d;
logic do_read, do_write;

assign req_addr = addr_q;

function automatic [DATA_W-1:0] apply_mask(
  input [DATA_W-1:0] oldd,
  input [DATA_W-1:0] newd,
  input [DATA_W/8-1:0] strb
);
  automatic [DATA_W-1:0] res_f;
  integer i_f;
  res_f = oldd;
  for (i_f = 0; i_f < DATA_W/8; i_f++) begin
    if (strb[i_f]) begin
      res_f[i_f*8 +: 8] = newd[i_f*8 +: 8];
    end
  end
  return res_f;
endfunction

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state_q  <= S_IDLE;
    addr_q   <= '0;
    wdata_q  <= '0;
    wstrb_q  <= '0;
    resp_rdata <= '0;
  end else begin
    state_q  <= state_d;
    addr_q   <= addr_d;
    wdata_q  <= wdata_d;
    wstrb_q  <= wstrb_d;
    if (do_read) begin
      resp_rdata <= mem[addr_q];
    end else if (do_write) begin
      resp_rdata <= '0;
    end
    if (do_write) begin
      mem[addr_q] <= apply_mask(mem[addr_q], wdata_q, wstrb_q);
    end
  end
end

always_comb begin
  req_ready  = 1'b0;
  resp_valid = 1'b0;
  rdata_d    = '0;
  do_read    = 1'b0;
  do_write   = 1'b0;
  state_d    = state_q
  addr_d     = addr_q;
  wdata_d    = wdata_q;
  wstrb_d    = wstrb_q;
  unique case (state_q)
    S_IDLE: begin
      req_ready = 1'b1;
      if (req_valid) begin
        addr_d   = req_addr;
        if (req_write) begin
          wdata_d   = req_wdata;
          wstrb_d   = req_wstrb;
          do_write  = 1'b1;
          state_d   = S_RESP;
        end else begin
          do_read   = 1'b1;
          state_d   = S_RESP;
        end
      end
    end
    S_RESP: begin
      resp_valid = 1'b1;
      if (resp_ready) begin
        state_d = S_IDLE;
      end
    end
    default: begin
      state_d = S_IDLE;
    end
  endcase
end

endmodule