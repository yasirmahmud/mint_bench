interface my_interface;
 logic sig;
 modport master(output sig);
 endinterface 

 module child_module(my_interface.master intf);
 assign intf.sig = 1'b0;
 endmodule
