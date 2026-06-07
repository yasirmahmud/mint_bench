module my_module_ex1 (input clk, input rst_n, input d, output reg q);
 function [0:0] is_reset_active;
 input reset_signal;
 begin is_reset_active = !reset_signal;
 end endfunction always @(posedge clk or negedge rst_n) begin if (is_reset_active(rst_n)) begin q <= 1'b0;
 end else begin q <= d;
 end end endmodule
