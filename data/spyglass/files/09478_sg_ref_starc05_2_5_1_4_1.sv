module STARC05_2_5_1_4_ex1 (input in1, in2, in3, in4, in5, in6, input sel1, sel2, sel3, sel4, sel5, sel6, output out_bus);
 wire out_bus;
 assign out_bus = sel1 ? in1 : 1'bz;
 assign out_bus = sel2 ? in2 : 1'bz;
 assign out_bus = sel3 ? in3 : 1'bz;
 assign out_bus = sel4 ? in4 : 1'bz;
 assign out_bus = sel5 ? in5 : 1'bz;
 assign out_bus = sel6 ? in6 : 1'bz;
 endmodule
