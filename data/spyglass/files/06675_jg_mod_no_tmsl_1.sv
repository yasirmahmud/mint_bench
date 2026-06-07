module missing_timescale_with_delay;
  reg clk;
  initial begin
    clk = 0;
    #5 clk = 1; // Explicit delay without timescale
    #5 clk = 0;
  end
endmodule
