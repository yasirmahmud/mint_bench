module curve_starc05_2_1_3_1_20260111_190503_761855_w47100_attempt8 (
  input [4:0] data_in_5bit,
  output [9:0] result_out_10bit
);

  // Function definition: expects a 10-bit input
  function [9:0] process_data (input [9:0] fn_input_10bit);
    begin
      process_data = fn_input_10bit;
    end
  endfunction

  // Call to the function 'process_data'
  // Argument 'data_in_5bit' is 5 bits wide.
  // Function input 'fn_input_10bit' expects 10 bits.
  // This bit-width mismatch (5 bits vs 10 bits) triggers STARC05-2.1.3.1.
  assign result_out_10bit = process_data(data_in_5bit);

endmodule
