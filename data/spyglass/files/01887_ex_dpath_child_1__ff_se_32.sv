// Dummy module definitions for SpyGlass linting

module ff_se_32(out, din, enable, clk);
  output [31:0] out;
  input  [31:0] din;
  input         enable;
  input         clk;
  always @(posedge clk) begin
    if (enable) begin
      out <= din;
    end
  end
endmodule
