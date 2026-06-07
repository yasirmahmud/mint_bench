module OverlapCasez1 (
  input [2:0] sel,
  output reg out
);

always @(*) begin
  casez (sel)
    3'b1z0: out = 1'b0;
    3'b10z: out = 1'b1;
    default: out = 1'b0;
  endcasez
end

endmodule
