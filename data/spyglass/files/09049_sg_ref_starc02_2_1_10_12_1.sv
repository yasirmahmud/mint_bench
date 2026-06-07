module STARC02_2_1_10_12_ex1 (input in_data, input enable, output out_data);
 trireg out_data;
 tranif1 (out_data, in_data, enable);
 endmodule
