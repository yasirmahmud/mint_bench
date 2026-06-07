module osc17;
  reg a, b;
  initial begin
    a = 0; // Initialize 'a' to a known value
    b = 0; // Initialize 'b' to a known value
  end
  always @* begin
    #1 a = ~b; // Introduce a delay to explicitly model oscillation
    #1 b = ~a; // Introduce a delay to explicitly model oscillation
  end
endmodule
