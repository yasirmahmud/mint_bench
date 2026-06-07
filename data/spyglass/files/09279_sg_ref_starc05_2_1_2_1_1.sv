module starc05_2_1_2_1_ex1 (input clk, input rst_n, input d, output reg q);
 function my_reset_func;
 input rst_in;
 begin my_reset_func = !rst_in;
 end endfunction always @(posedge clk or posedge rst_n) begin if (my_reset_func(rst_n)) q <= 1'b0;
 else q <= d;
 end endmodule
