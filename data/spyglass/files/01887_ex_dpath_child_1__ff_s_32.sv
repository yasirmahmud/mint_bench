module ff_s_32(out, din, clk);
  output [31:0] out;
  input  [31:0] din;
  input         clk;
  always @(posedge clk) begin
    out <= din;
  end
endmodule
