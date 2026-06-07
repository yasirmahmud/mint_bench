module osc16;
  reg a; // Changed from 'wire' to 'reg' to allow procedural assignment.
  always @* a = ~a;
endmodule
