module curve_w293_20260111_035056_attempt5;

  // W293: Function returns a real value which is not synthesizable
  function real calculate_ratio;
    input integer numerator;
    input integer denominator;
    begin
      // A function declared to return a 'real' value (like 'calculate_ratio')
      // is inherently non-synthesizable. This function performs real-number division.
      if (denominator != 0) begin
        calculate_ratio = $rtoi(numerator) / $rtoi(denominator); // Perform real division
      end else begin
        // Provide a default real value for division by zero.
        calculate_ratio = 0.0;
      end
    end
  endfunction

endmodule
