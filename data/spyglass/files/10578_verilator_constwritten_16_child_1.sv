module const_write_16;
  logic [3:0] reg_val = 4'b0000; // Removed 'const' keyword to allow re-assignment
  initial begin
    repeat(1) reg_val = 4'b1111;
  end
endmodule
