`timescale 1ns/1ps

module disallow_force_equi_net_ex1 (
  output wire w2_out // Expose w2 as an output to resolve 'not read' violation
);
  wire w1;
  wire w2_internal; // Use an internal wire for the original w2 logic

  assign w2_internal = w1;
  assign w2_out = w2_internal;

  `ifndef SYNTHESIS // Wrap initial block to prevent synthesis warning
  initial begin
    force w1 = 1'b0;
    force w2_internal = 1'b1; // Apply force to the internal wire
    #10 release w1;
    release w2_internal;
  end
  `endif

endmodule
