module ff_se_30(out, din, enable, clk);
  output [29:0] out;
  input  [29:0] din;
  input         enable;
  input         clk;
  always @(posedge clk) begin
    if (enable) begin
      out <= din;
    end
  end
endmodule
