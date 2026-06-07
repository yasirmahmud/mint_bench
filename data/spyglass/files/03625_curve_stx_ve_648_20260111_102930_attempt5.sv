module curve_stx_ve_648_20260111_102930_attempt5;

  // STX_VE_648: This 'output' declaration triggers the violation
  // because the module header does not have an explicit port list.
  output reg result_flag;

  initial begin
    result_flag = 1'b0; // Assign a value to avoid unused signal warnings
  end

endmodule
