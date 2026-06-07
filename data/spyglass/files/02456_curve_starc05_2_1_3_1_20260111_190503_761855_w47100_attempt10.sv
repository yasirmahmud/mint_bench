module curve_starc05_2_1_3_1_20260111_190503_761855_w47100_attempt10 (
  input wire data_in_1bit,
  output wire [3:0] final_result_4bit
);

  // Function definition: expects a 4-bit input 'op_in_4bit'
  function [3:0] simple_adder (input [3:0] op_in_4bit);
    begin
      // Simple operation to ensure function is used and returns a value
      // Adding 1 to the input for a basic function body
      simple_adder = op_in_4bit + 1;
    end
  endfunction

  // Call to the function 'simple_adder'.
  // The argument 'data_in_1bit' is 1 bit wide.
  // The function input 'op_in_4bit' expects 4 bits.
  // This bit-width mismatch (1 bit vs 4 bits) triggers STARC05-2.1.3.1.
  assign final_result_4bit = simple_adder(data_in_1bit);

endmodule
