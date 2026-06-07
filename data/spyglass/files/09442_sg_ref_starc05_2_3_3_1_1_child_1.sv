module stac05_2_3_3_1_ex1 (input CLK1, input CLK2, input IN1, output reg OUT1);
  // The original design uses edges of multiple clocks in a single always block,
  // which is unsynthesizable and violates STARC05-2.3.3.1.
  // A single flip-flop (implied by 'output reg OUT1') must be clocked by only one clock.
  // To resolve the violation while maintaining a synthesizable design, a single clock
  // must be chosen for the sequential block. Assuming CLK1 is the intended primary clock.
  // If the intent was to capture 'IN1' on both clock edges, this would typically require
  // either a clock multiplexer (with its own design challenges) or two separate flip-flops
  // followed by a data selection mechanism, which would change the 'OUT1' from a single
  // flip-flop to a combinational output of multiple flip-flops.
  // This solution picks CLK1 to make the block synthesizable and resolve the linting issues.
  always @(posedge CLK1) begin
    OUT1 <= IN1;
  end
endmodule
