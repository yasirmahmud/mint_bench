module my_module_ex1 (input [1:0] in_sig, output out_sig);
 assign out_sig = (in_sig == 2'b1x) ? 1'b1 : 1'b0;
 endmodule
