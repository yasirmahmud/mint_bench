module const_write_20;
  int loop_var = 0; // Removed 'const' keyword to allow re-assignment
  initial begin
    forever begin
      loop_var = 1;
      #1;
    end
  end
endmodule
