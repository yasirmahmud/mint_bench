module ff_sre_4(out, din, clk, enable, reset_l);
  output [3:0]  out;
  input  [3:0]  din;
  input         clk;
  input         enable;
  input         reset_l;
  always @(posedge clk) begin
    if (~reset_l) begin
      out <= 4'b0;
    end else if (enable) begin
      out <= din;
    end
  end
endmodule
