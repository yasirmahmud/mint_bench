module curve_w293_20260111_035056_attempt3;

  // W293: Function returns a real value which is not synthesizable
  function real calculate_real_quotient;
    input integer dividend_val;
    input integer divisor_val;
    begin
      // Perform division ensuring a real result by mixing integer and real types.
      // Multiplying by 1.0 ensures the expression becomes real before division.
      calculate_real_quotient = (dividend_val * 1.0) / divisor_val;
    end
  endfunction

endmodule
