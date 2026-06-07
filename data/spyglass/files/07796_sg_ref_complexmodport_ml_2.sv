module top_ex2;
 interface my_interface_ex2;
 logic [7:0] a;
 logic [7:0] b;
 modport complex_mp (output {a, b});
 endinterface my_interface_ex2 i_inst();
 endmodule
