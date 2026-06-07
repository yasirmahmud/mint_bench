module curve_w293_20260112_013409_909873_w47152_attempt15;

  // W293: Function returns a real value which is not synthesizable
  function real compute_adjusted_real_output(input integer input_val);
    real intermediate_real;
    begin
      // Perform a calculation that involves an integer input and produces a real result.
      // $cast is used to explicitly convert the integer to real for the multiplication.
      intermediate_real = $cast(real, input_val) * 2.5; 
      compute_adjusted_real_output = intermediate_real;
    end
  endfunction

endmodule
