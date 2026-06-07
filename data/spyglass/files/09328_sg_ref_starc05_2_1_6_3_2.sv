module star_c05_2_1_6_3_ex2 (input [1:0] sel, output out);
 reg data_array [0:4];
 assign out = data_array[sel + 1];
 endmodule
