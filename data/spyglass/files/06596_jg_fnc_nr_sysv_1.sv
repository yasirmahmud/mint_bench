module test_bits_violation;
  logic [7:0] my_data;
  initial begin
    $display("Number of bits: %0d", $bits(my_data));
  end
endmodule
