module top4;
  typedef struct packed { bit a; bit b; } my_struct_t;
  my_struct_t data[0:3];
  // synthesis translate_off
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] = '{a:1, b:0}; // Changed to blocking assignment to resolve BLKLOOPINIT concern
    end
    // Added display statements to read 'data' and resolve W528 warnings
    $display("Initialized data values:");
    for (int i = 0; i < 4; i++) begin
      $display("  data[%0d]: a=%0d, b=%0d", i, data[i].a, data[i].b);
    end
  end
  // synthesis translate_on
endmodule
