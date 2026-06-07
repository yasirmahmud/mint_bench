module stac_2_1_2_3_ex1;
 output reg [7:0] data_out; // Made an output to resolve W528
 function [7:0] my_func;
 input [7:0] data_in;
 reg [7:0] temp_reg;
 begin 
  temp_reg = data_in; // Changed to blocking assignment to resolve SYNTH_5036 and WRN_44
  my_func = temp_reg;
 end 
 endfunction;
 assign data_out = my_func(8'hAA);
 endmodule
