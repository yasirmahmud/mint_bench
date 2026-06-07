module curve_w293_20260111_185109_929746_w47100_attempt7;

  function real calculate_sqrt;
    input integer value_in;
    begin
      calculate_sqrt = $sqrt($itor(value_in));
    end
  endfunction

endmodule
