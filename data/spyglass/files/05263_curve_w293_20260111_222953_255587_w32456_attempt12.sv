module curve_w293_20260111_222953_255587_w32456_attempt12;

  // W293: Function returns a real value which is not synthesizable
  function real get_scaled_real;
    input integer in_val;
    begin
      // The function's return type 'real' is the cause of the W293 violation.
      // The logic inside is kept simple to avoid other violations.
      get_scaled_real = 3.14159 * in_val; // Example distinct operation
    end
  endfunction

  // To avoid unused signal warnings, we can instantiate and use the function minimally.
  wire dummy_out;
  assign dummy_out = (get_scaled_real(1) > 0.0) ? 1'b1 : 1'b0;

endmodule
