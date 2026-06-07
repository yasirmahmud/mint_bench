module curve_w293_20260111_185109_929746_w47100_attempt8;

  function real get_fixed_real_value;
    // This function returns a synthesizable real value.
    // SpyGlass will flag this function as its return type is real.
    begin
      get_fixed_real_value = 1.2345;
    end
  endfunction

endmodule
