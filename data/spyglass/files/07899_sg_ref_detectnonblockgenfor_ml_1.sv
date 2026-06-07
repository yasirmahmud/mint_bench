module detect_non_block_gen_for_ml_ex1 (input clk);
 genvar i;
 generate for (i = 0; i < 1; i = i + 1) wire my_signal_i;
 endgenerate endmodule
