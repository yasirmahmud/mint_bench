module starc05_2_1_2_1_ex2 (input clk, input rst_n, input d, output reg q);
 function [0:0] check_reset;
 input rst_in;
 begin check_reset = (rst_in == 1'b0);
 end endfunction always @(posedge clk or negedge rst_n) begin if (check_reset(rst_n)) begin q <= 1'b0;
 end else begin q <= d;
 end end endmodule
