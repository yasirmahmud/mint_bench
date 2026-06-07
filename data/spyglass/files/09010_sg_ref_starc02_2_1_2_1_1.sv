module STARC02_2_1_2_1_ex1(input clk, input rst, input d, output reg q);
 function is_rst(input r);
 begin is_rst = r;
 end endfunction always @(posedge clk or posedge rst) if (is_rst(rst)) q <= 1'b0;
 else q <= d;
 endmodule
