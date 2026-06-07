interface my_interface_ex1;
 logic clk;
 logic rst;
 logic [7:0] data;
 endinterface module top_module_ex1(input wire i_clk, input wire i_rst);
 my_interface_ex1 if_inst();
 assign if_inst.clk = i_clk;
 assign if_inst.rst = i_rst;
 endmodule
