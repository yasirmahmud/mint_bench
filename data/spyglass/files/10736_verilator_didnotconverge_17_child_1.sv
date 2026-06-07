module osc17;
  reg a, b; // Changed from wire to reg to allow procedural assignments
  always @* begin
    a = ~b;
    b = ~a;
  end
endmodule
