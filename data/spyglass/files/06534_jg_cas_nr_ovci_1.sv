module OverlapCasex1 (
  input [1:0] sel,
  output reg out
);

always @(*) begin
  casex (sel)
    2'b0x: out = 1'b0;
    2'bx0: out = 1'b1;
    default: out = 1'b0;
  endcasex
end

endmodule
