interface my_interface;
 logic sig;
 modport master(output sig);
 endinterface module child_module(my_interface.master intf);
 assign intf.sig = 1'b0;
 endmodule
 module top_module_ex1;
 my_interface i_inst();
 child_module c_inst(i_inst.master);
 endmodule
