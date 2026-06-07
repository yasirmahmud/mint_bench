module overlap_ex18 (
  input [2:0] sel,
  output reg out
);

  always @(sel) begin
    out = 1'b0;
  end
endmodule
