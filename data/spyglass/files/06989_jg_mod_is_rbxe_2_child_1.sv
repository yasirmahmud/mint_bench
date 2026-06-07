module RealValueExample2();
  real another_float_value;

  initial begin
    another_float_value = 3.14; // Assignment moved to initial block to resolve SYNTH_89
    $display("another_float_value = %f", another_float_value); // Read the variable to resolve W528
  end
endmodule
