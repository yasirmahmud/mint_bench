module curve_w293_20260111_035056_attempt4;

  // W293: Function returns a real value which is not synthesizable
  function real compute_sqrt_of_input;
    input integer value_in;
    begin
      // A function declared to return a 'real' value is inherently non-synthesizable.
      // Using a real system function like $sqrt further emphasizes this.
      if (value_in >= 0) begin
        compute_sqrt_of_input = $sqrt(value_in);
      end else begin
        // Provide a default real value for negative input to avoid issues.
        compute_sqrt_of_input = 0.0;
      end
    end
  endfunction

endmodule
