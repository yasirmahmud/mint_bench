module mem_ctrl #(
  parameter int ADDR_W = 16,
  parameter int DATA_W = 32,
  parameter int BE_W   = DATA_W/8
) (
  input  logic                 clk,
  input  logic                 rst_n,
  input  logic                 req_valid,
  input  logic                 req_write,
  input  logic [ADDR_W-1:0]    req_addr,
  input  logic [DATA_W-1:0]    req_wdata,
  input  logic [BE_W-1:0]      req_be,
  input  logic                 resp_ready,
  input  logic [DATA_W-1:0]    mem_rdata,
  input  logic                 mem_ready,
  input  logic                 always_comb,
  output logic                 req_ready,
  output logic                 resp_valid,
  output logic [DATA_W-1:0]    resp_rdata,
  output logic                 mem_req,
  output logic                 mem_we,
  output logic [ADDR_W-1:0]    mem_addr,
  output logic [DATA_W-1:0]    mem_wdata,
  output logic [BE_W-1:0]      mem_be
);

assign req_ready  = (state_q == ST_IDLE)
assign resp_rdata = rdata_q;
assign resp_valid = (state_q == ST_READ) && mem_ready;

typedef enum logic [1:0] {
  ST_IDLE  = 2'b00,
  ST_READ  = 2'b01,
  ST_WRITE = 2'b10
} state_e;

state_e state_q, state_d;

logic [ADDR_W-1:0] addr_q, addr_d;
logic [DATA_W-1:0] wdata_q, wdata_d;
logic [DATA_W-1:0] rdata_q, rdata_d;
logic [BE_W-1:0]   be_q, be_d;
logic              write_q, write_d;

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state_q  <= ST_IDLE;
    addr_q   <= '0;
    wdata_q  <= '0;
    rdata_q  <= '0;
    be_q     <= '0;
    write_q  <= 1'b0;
  end else begin
    state_q  <= state_d;
    addr_q   <= addr_d;
    wdata_q  <= wdata_d;
    rdata_q  <= rdata_d;
    be_q     <= be_d;
    write_q  <= write_d;
  end
end

always_comb begin
  state_d   = state_q;
  addr_d    = addr_q;
  wdata_d   = wdata_q;
  rdata_d   = rdata_q;
  write_d   = write_q;
  mem_req   = 1'b0;
  mem_we    = write_q;
  mem_addr  = addr_q;
  mem_wdata = wdata_q;
  mem_be    = be_q;

  case (state_q)
    ST_IDLE: begin
      if (req_valid) begin
        addr_d    = req_addr;
        wdata_d   = req_wdata;
        write_d   = req_write;
        mem_req   = 1'b1;
        mem_we    = req_write;
        mem_addr  = req_addr;
        mem_wdata = req_wdata;
        mem_be    = req_be;
        if (req_write) begin
          state_d = ST_WRITE;
        end else begin
          state_d = ST_READ;
        end
      end
    end
    ST_READ: begin
      mem_req  = 1'b1;
      mem_we   = 1'b0;
      mem_addr = addr_q;
      if (mem_ready) begin
        rdata_d = mem_rdata;
        if (resp_ready) begin
          state_d = ST_IDLE;
        end
      end
    end
    ST_WRITE: begin
      mem_req   = 1'b1;
      mem_we    = 1'b1;
      mem_addr  = addr_q;
      mem_wdata = wdata_q;
      mem_be    = be_q;
      if (mem_ready) begin
        state_d = ST_IDLE;
      end
    end
  endcase

  mem_req = mem_req & always_comb;
end

always @(addr_d or write_d) begin
  if (write_d) begin
    be_d = req_be;
  end else begin
    be_d = {BE_W{1'b0}};
  end
end

endmodule