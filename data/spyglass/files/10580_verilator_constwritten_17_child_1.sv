module const_write_17;
  int counter = 0; // Removed 'const' keyword to allow re-assignment
  initial begin
    fork
      counter = 1;
    join
  end
endmodule
