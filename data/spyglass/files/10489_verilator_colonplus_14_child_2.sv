module test14;
  logic [7:0] vector_a;
  // Initialize vector_b to resolve "read but never set" warning for vector_b[7:4]
  logic [7:0] vector_b = 8'hAA; // Example initialization

  assign vector_a[0 +: 4] = vector_b[4 +: 4];

  // Add an initial block to "read" vector_a[3:0] and resolve "set but not read" warning
  initial begin
    $display("vector_a[3:0] = %h", vector_a[0 +: 4]);
  end
endmodule
