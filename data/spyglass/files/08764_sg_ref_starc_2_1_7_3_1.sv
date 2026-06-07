module starc_2_1_7_3_ex1(input IN1, output [3:0] SIG);
 assign SIG = (2 => IN1, others => '0');
 endmodule
