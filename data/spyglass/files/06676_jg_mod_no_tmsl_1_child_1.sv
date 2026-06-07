`timescale 1ns / 1ps
module missing_timescale_with_delay;
  reg clk;

  // synopsys translate_off
  // SpyGlass Violation Fix: SYNTH_5143 - Initial block is ignored for synthesis.
  // This block is for simulation stimulus and is marked to be ignored by synthesis tools.
  initial begin
    clk = 0;
    #5 clk = 1;
    #5 clk = 0;
  end
  // synopsys translate_on

  // SpyGlass Violation Fix: W528 - Variable 'clk' set but not read.
  // Adding an observation point for 'clk' for simulation purposes.
  always @(posedge clk or negedge clk) begin
    $display("Time: %0t, clk = %b", $time, clk);
  end

endmodule
