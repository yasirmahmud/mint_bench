module curve_stx_ve_605_20260110_121033_attempt2 ();

  parameter MY_PARAM = 100;

  function automatic int get_param_value;
  begin
    MY_PARAM = 200; // FATAL: Illegal attempt to assign to a parameter within a function
    get_param_value = MY_PARAM;
  end
  endfunction

  initial begin
    int val;
    val = get_param_value(); // Call the function to ensure it is not optimized away
  end

endmodule
