interface my_sub_interface;
 logic a;
 endinterface interface my_parent_interface_ex2;
 my_sub_interface sub_if_inst();
 logic b;
 endinterface module top_module_ex2(input clk);
 my_parent_interface_ex2 parent_if_inst();
 endmodule
