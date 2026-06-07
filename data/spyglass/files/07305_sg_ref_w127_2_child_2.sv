`timescale 1ns/1ps

module W127_ex2 (
    output wire a
);

 reg b;

 initial begin
  b = 1'b0; // Initialize 'b' to resolve W123: Variable 'b' read but never set
 end

 assign #1 a = b;

endmodule
