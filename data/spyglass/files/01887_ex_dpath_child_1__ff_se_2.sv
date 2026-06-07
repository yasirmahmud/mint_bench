module ff_se_2(out, din, enable, clk);
  output [1:0]  out;
  input  [1:0]  din;
  input         enable;
  input         clk;
  always @(posedge clk) begin
    if (enable) begin
      out <= din;
    end
  end
endmodule
