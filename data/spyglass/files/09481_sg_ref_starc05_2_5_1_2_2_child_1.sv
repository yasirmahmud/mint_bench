module STARC05_2_5_1_2_ex2 (input in_data, input sel1, input sel2, output out_data);
 assign out_data = (sel1 & sel2) ? in_data : 1'bz;
 endmodule
