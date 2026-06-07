module curve_wrn_44_20260111_053310_attempt5 (
  input [7:0] operand_a,
  output [7:0] output_val
);

  // WRN_44: Non-blocking assignment statement in a function.
  // The IEEE 1364-2001/2005 Verilog standards do not support this.
  function automatic [7:0] compute_result_func;
    input [7:0] input_arg;
    
    begin
      // This non-blocking assignment (<=) directly to the function's return variable
      // inside the function definition body will trigger WRN_44.
      compute_result_func <= input_arg * 2;
    end
  endfunction

  // The function is called in a continuous assignment to drive an output.
  // This ensures the function is part of the elaborated design and not optimized away.
  assign output_val = compute_result_func(operand_a);

endmodule
