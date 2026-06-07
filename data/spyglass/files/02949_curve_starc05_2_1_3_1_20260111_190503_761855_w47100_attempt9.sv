module curve_starc05_2_1_3_1_20260111_190503_761855_w47100_attempt9 (
  input [3:0] data_arg_4bit,
  output [31:0] result_32bit
);

  // Function definition: expects a 32-bit input 'fn_param_32bit'
  function [31:0] calc_val (input [31:0] fn_param_32bit);
    begin
      // Simple operation to ensure function is used and returns a value
      calc_val = fn_param_32bit + 1;
    end
  endfunction

  // Call to the function 'calc_val'.
  // The argument 'data_arg_4bit' is 4 bits wide.
  // The function input 'fn_param_32bit' expects 32 bits.
  // This bit-width mismatch (4 bits vs 32 bits) triggers STARC05-2.1.3.1.
  assign result_32bit = calc_val(data_arg_4bit);

endmodule
