`timescale 1ns/1ps
module osc20;
  wire a, b;
  // Fixed: The original code 'assign a = b; assign b = a;' created a combinational loop.
  // To resolve the CombLoop violation and prevent DIDNOTCONVERGE, the loop must be broken.
  // This fix assigns 'a' to a constant value, making 'b' also constant and breaking the cycle.
  assign a = 1'b0;
  assign b = a;

`ifdef SYNTHESIS
  // SYNTH_5143: Initial blocks are ignored for synthesis. This 'ifdef' block
  // ensures the initial block is only present during simulation, resolving the warning.
`else
  initial begin
    #1 $display("Tick");
    #1 $finish;
  end
`endif
endmodule
