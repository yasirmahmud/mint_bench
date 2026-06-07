module curve_w293_20260111_035056_attempt2;

  // W293: Function returns a real value which is not synthesizable
  function real get_real_from_input;
    input real input_real_val;
    begin
      get_real_from_input = input_real_val;
    end
  endfunction

endmodule
