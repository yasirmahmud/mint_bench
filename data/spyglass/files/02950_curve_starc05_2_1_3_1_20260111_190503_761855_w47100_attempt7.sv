module curve_starc05_2_1_3_1_20260111_190503_761855_w47100_attempt7 (
  input [7:0] module_in_8bit,
  output [15:0] module_out
);

  // Function defined with a 16-bit input
  function [15:0] my_calc (input [15:0] fn_data);
    begin
      my_calc = fn_data;
    end
  endfunction

  // Call the function 'my_calc' with 'module_in_8bit' (8 bits).
  // The function's input 'fn_data' expects 16 bits.
  // This bit-width mismatch (8 bits vs 16 bits) triggers STARC05-2.1.3.1.
  assign module_out = my_calc(module_in_8bit);

endmodule
