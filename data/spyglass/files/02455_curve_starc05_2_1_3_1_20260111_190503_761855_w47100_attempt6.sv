module curve_starc05_2_1_3_1_20260111_190503_761855_w47100_attempt6 (
  input [3:0] in_4bit,
  output [31:0] out_32bit
);

  // Function with a 32-bit input
  function [31:0] my_operation_func (input [31:0] func_input_32bit);
    begin
      my_operation_func = func_input_32bit;
    end
  endfunction

  // Call the function with a 4-bit argument 'in_4bit',
  // which mismatches the 32-bit function input 'func_input_32bit'.
  // This triggers STARC05-2.1.3.1 as the argument is 4 bits and the input is 32 bits.
  assign out_32bit = my_operation_func(in_4bit);

endmodule
