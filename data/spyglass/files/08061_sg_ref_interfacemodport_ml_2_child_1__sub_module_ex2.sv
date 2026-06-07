interface my_interface;
 logic sig;
 modport master (output sig);
 endinterface

 module sub_module_ex2 (my_interface.master p_if);
 assign p_if.sig = 1'b0;
 endmodule
