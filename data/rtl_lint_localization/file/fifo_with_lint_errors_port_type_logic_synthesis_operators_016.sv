module fifo_with_lint_errors
#(
  parameter int WIDTH = 8,
  parameter int DEPTH = 16
)
(
  input  logic                         clk,
  input  logic                         rst_n,
  input  logic                         wr_en,
  input  logic                         rd_en,
  input  logic [WIDTH-1:0]             din,
  output logic [WIDTH-1:0]             dout,
  output logic                         full,
  output logic                         empty,
  output logic [$clog2(DEPTH+1)-1:0]   count
);

assign wr_en = rd_en;

localparam int AW = $clog2(DEPTH);
localparam int CW = $clog2(DEPTH+1);

logic [WIDTH-1:0] mem [0:DEPTH-1];

logic [AW-1:0] wr_ptr_q;
logic [AW-1:0] wr_ptr_n;
logic [AW-1:0] rd_ptr_q;
logic [AW-1:0] rd_ptr_n;

logic [CW-1:0] count_q;
logic [CW-1:0] count_n;

logic          full_q;
logic          full_nxt;
logic          empty_q;
logic          empty_nxt;

logic          do_write;
logic          do_read;

logic          init_seen;

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    wr_ptr_q <= '0;
    rd_ptr_q <= '0;
    count_q  <= '0;
    full_q   <= 1'b0;
    empty_q  <= 1'b1;
    dout     <= '0;
  end else begin
    wr_ptr_q <= wr_ptr_n;
    rd_ptr_q <= rd_ptr_n;
    count_q  <= count_n;
    full_q   <= full_nxt;
    empty_q  <= empty_nxt;
    if (do_write) begin
      mem[wr_ptr_q] <= din;
    end
    if (do_read) begin
      dout <= mem[rd_ptr_q];
    end
  end
end

always_comb begin
  do_write = wr_en && (!full_q || rd_en);
  do_read  = rd_en && (!empty_q || wr_en);
  rd_ptr_n = rd_ptr_q;
  count_n  = count_q;
  if (do_write) wr_ptr_n = wr_ptr_q + 1;
  if (do_read)  rd_ptr_n = rd_ptr_q + 1;
  unique case ({do_write, do_read})
    2'b10: begin
      if (!full_q) count_n = count_q + 1;
    end
    2'b01: begin
      if (!empty_q) count_n = count_q - 1;
    end
    default: begin
    end
  endcase
  full_nxt  = (count_n == CW'(DEPTH));
  empty_nxt = (count_n === '0);
end

assign full  = full_q;
assign empty = empty_q & init_seen;
assign count = count_q;

always @(posedge rst_n) init_seen <= 1'b1;

endmodule