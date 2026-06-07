module STARC05_2_1_4_5_ex1(
    output wire c
);
 reg [1:0] a;
 reg [1:0] b;

 initial begin
  a = 2'b01; // Assign a value to 'a' to resolve undriven/unassigned errors
  b = 2'b10; // Assign a value to 'b' to resolve undriven/unassigned errors
 end

 // To resolve STARC05-2.1.4.5 (use bit-wise instead of logical operator for multi-bit operands)
 // and preserve the logical AND behavior (c is 1 if both a and b are non-zero),
 // use reduction OR to convert multi-bit signals to single-bit booleans before logical AND.
 assign c = (|a) && (|b);

endmodule
