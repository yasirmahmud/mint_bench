module my_module_ex2 (input in1, in2, in3, in4, in5, in6, en1, en2, en3, en4, en5, en6, output out_bus);
 wire out_bus;
 assign out_bus = en1 ? in1 : 1'bz;
 assign out_bus = en2 ? in2 : 1'bz;
 assign out_bus = en3 ? in3 : 1'bz;
 assign out_bus = en4 ? in4 : 1'bz;
 assign out_bus = en5 ? in5 : 1'bz;
 assign out_bus = en6 ? in6 : 1'bz;
 endmodule
