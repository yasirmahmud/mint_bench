module top_module_ex1;
 my_interface i_inst();
 child_module c_inst(i_inst.master);

 // Fix for SpyGlass W528: Variable 'i_inst.sig' set but not read.
 // Add a dummy read to consume the value of i_inst.sig within top_module_ex1.
 wire unused_sig_read = i_inst.sig;
 endmodule
