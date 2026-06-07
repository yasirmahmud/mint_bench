module meta_sync #(
  parameter DWIDTH = 1
) (
  input             clk,
  input             reset_n,
  input  [DWIDTH-1:0] in,
  output [DWIDTH-1:0] out
);

  reg [DWIDTH-1:0] sync_reg1;
  reg [DWIDTH-1:0] sync_reg2;

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      sync_reg1 <= DWIDTH'b0;
      sync_reg2 <= DWIDTH'b0;
    end else begin
      sync_reg1 <= in;
      sync_reg2 <= sync_reg1;
    end
  end

  assign out = sync_reg2;

endmodule
