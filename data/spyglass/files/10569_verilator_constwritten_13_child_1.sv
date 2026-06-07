module const_write_13;
  logic clk; // Moved declaration of 'clk' before its use
  logic [0:0] my_bit; // Removed 'const' keyword to allow modification, as intended by the always_ff block
  always_ff @(posedge clk) begin
    my_bit <= 1'b1;
  end
endmodule
