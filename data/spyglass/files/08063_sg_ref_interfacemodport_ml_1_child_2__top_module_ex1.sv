module top_module_ex1;
 my_interface i_inst();
 child_module c_inst(i_inst.master);

 // Fix for SpyGlass W528: Variable 'i_inst.sig' set but not read.
 // The previous 'wire unused_sig_read = i_inst.sig;' caused a new W528 on 'unused_sig_read'.
 // Using a dummy_consumer module is a common synthesizable idiom to consume
 // an output signal that is intentionally not used by the parent module,
 // thus resolving both the original 'i_inst.sig' warning and the subsequent 'unused_sig_read' warning.
 dummy_consumer i_inst_sig_consumer(.dummy_signal(i_inst.sig));
 endmodule
