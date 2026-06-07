module curve_w293_20260111_222953_255587_w32456_attempt11;

  // W293: Function returns a real value which is not synthesizable
  function real get_default_real_value;
    // No inputs, no complex logic, just to trigger the return type violation
    begin
      get_default_real_value = 0.0; // Assign a real value to satisfy function syntax
    end
  endfunction

endmodule
