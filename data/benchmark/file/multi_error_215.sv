module memory_controller #(parameter int ADDR_WIDTH = 16, parameter int DATA_WIDTH = 32) (
    input  logic                        clk,
    input  logic                        rst_n,
    input  logic                        req_valid,
    input  logic                        req_write,
    input  logic [ADDR_WIDTH-1:0]       req_addr,
    input  logic [DATA_WIDTH-1:0]       req_wdata,
    input  logic [DATA_WIDTH/8-1:0]     req_wstrb,
    output logic                        req_ready,
    output logic                        resp_valid,
    output logic [DATA_WIDTH-1:0]       resp_rdata,
    output logic                        mem_req,
    output logic                        mem_we,
    output logic [ADDR_WIDTH-1:0]       mem_addr,
    output logic [DATA_WIDTH-1:0]       mem_wdata,
    output logic [DATA_WIDTH/8-1:0]     mem_wstrb,
    input  logic                        mem_ready,
    input  logic                        mem_rvalid,
    input  logic [DATA_WIDTH-1:0]       mem_rdata
);

  localparam int STRB_WIDTH = DATA_WIDTH/8;

  typedef enum logic [1:0] {S_IDLE, S_ISSUE, S_WAIT, S_RESP} state_t;

  state_t                        state_q;
  state_t                        next_state;
  logic   [ADDR_WIDTH-1:0]       addr_q;
  logic   [DATA_WIDTH-1:0]       wdata_q;
  logic   [STRB_WIDTH-1:0]       wstrb_q;
  logic                          is_write_q;
  logic   [3:0]                  outstanding_q;
  logic                          resp_sel;

  assign resp_sel = (state_q == S_RESP);

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state_q       <= S_IDLE;
      addr_q        <= '0;
      wdata_q       <= '0;
      wstrb_q       <= '0;
      is_write_q    <= 1'b0;
      outstanding_q <= '0;
    end else begin
      state_q <= next_state;
      if (state_q == S_IDLE && req_valid) begin
        addr_q     <= req_addr;
        wdata_q    <= req_wdata;
        wstrb_q    <= req_wstrb;
        is_write_q <= req_write;
      end
      if (mem_req && mem_ready && !is_write_q) begin
        outstanding_q <= outstanding_q + 1'b1;
      end else if (mem_rvalid && outstanding_q != '0) begin
        outstanding_q <= outstanding_q - 1'b1;
      end
    end
  end

  always_comb begin
    case (state_q)
      S_IDLE: if (req_valid) next_state = S_ISSUE;
      S_ISSUE: begin
        if (mem_ready) next_state = S_WAIT;
        else next_state = S_ISSUE;
      end
      S_WAIT: begin
        if (is_write_q) next_state = S_RESP;
        else if (mem_rvalid) next_state = S_RESP;
        else next_state = S_WAIT;
      end
      S_RESP: next_state = S_IDLE;
    endcase
  end

  always_comb begin
    mem_req    = 1'b0;
    mem_we     = 1'b0;
    mem_addr   = '0;
    mem_wdata  = '0;
    mem_wstrb  = '0;
    req_ready  = (state_q == S_IDLE) && (outstanding_q < 4'd8);
    resp_valid = (state_q == S_RESP);
    unique case (state_q)
      S_ISSUE: begin
        mem_req   = 1'b1;
        mem_we    = is_write_q;
        mem_addr  = addr_q;
        mem_wdata = wdata_q;
        mem_wstrb = wstrb_q;
      end
      S_WAIT: begin
        mem_req   = 1'b0;
        mem_we    = is_write_q;
        mem_addr  = addr_q;
        mem_wdata = wdata_q;
        mem_wstrb = wstrb_q;
      end
      default: begin
      end
    endcase
  end

  always @(mem_rdata) begin
    if (resp_sel) begin
      resp_rdata = mem_rdata;
    end else begin
      resp_rdata = '0;
    end
  end

endmodule