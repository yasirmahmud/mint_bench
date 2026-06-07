module star_2_1_8_9_ex2(input [1:0] sel, output reg [7:0] out_val);
 function [7:0] my_func(input [1:0] a);
 if (a == 2'b00) begin return 8'd10;
 end endfunction assign out_val = my_func(sel);
 endmodule
