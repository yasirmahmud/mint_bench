module ff_sr(out, din, clk, reset_l);
  output        out;
  input         din;
  input         clk;
  input         reset_l;
  always @(posedge clk) begin
    if (~reset_l) begin
      out <= 1'b0;
    end else begin
      out <= din;
    end
  end
endmodule
