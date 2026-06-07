interface my_interface_ex2 #(parameter WIDTH = 8);
 logic [WIDTH-1:0] data;
 endinterface module top_module_ex2 (input clk);
 my_interface_ex2 #(.WIDTH(16)) if_inst();
 endmodule
