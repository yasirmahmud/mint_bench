module curve_w293_20260112_013409_909873_w47152_attempt14;

  // W293: Function returns a real value which is not synthesizable
  function real get_scaled_real_value;
    real internal_scale_factor;
    begin
      internal_scale_factor = 0.5;
      get_scaled_real_value = 10.0 * internal_scale_factor; // Return a real value from a calculation involving a local real variable
    end
  endfunction

endmodule
