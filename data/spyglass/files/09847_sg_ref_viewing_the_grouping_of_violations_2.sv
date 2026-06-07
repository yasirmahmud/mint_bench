module my_design_ex2 (input wire clk, input wire reset_n, input wire data_in, output wire data_out);
 assign data_out = clk & reset_n;
 endmodule
