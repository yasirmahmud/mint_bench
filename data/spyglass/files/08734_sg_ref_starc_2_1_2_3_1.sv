module stac_2_1_2_3_ex1;
 reg [7:0] data_out;
 function [7:0] my_func;
 input [7:0] data_in;
 reg [7:0] temp_reg;
 begin temp_reg <= data_in;
 my_func = temp_reg;
 end endfunction;
 assign data_out = my_func(8'hAA);
 endmodule
