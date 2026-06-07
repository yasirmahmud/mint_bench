module curve_stx_ve_775_20260110_200225_attempt13 (
  input wire [31:0] data_in,
  output wire [31:0] data_out
);

  // Connect primary output to avoid unused port warnings.
  assign data_out = data_in;

  // The target rule: STX_VE_775 - Initial statement not allowed in this scope
  // An 'initial' block is strictly forbidden within a function or task definition in Verilog-2001.
  function integer my_illegal_function;
    input integer func_input_val;
    // The 'initial' block and its contents were removed as they are not allowed in a function scope.
    my_illegal_function = func_input_val + 1;
  endfunction

  // Use the function to avoid "unused function" warnings.
  integer func_call_result;

  always @(*) begin
    func_call_result = my_illegal_function(data_in);
  end

endmodule
