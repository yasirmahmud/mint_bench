module my_module_ex2 (input clk, rst_n, d, output reg q);
 function automatic [0:0] is_reset_active(input rst_signal);
 begin is_reset_active = !rst_signal;
 end endfunction always @(posedge clk or negedge rst_n) begin if (is_reset_active(rst_n)) begin q <= 1'b0;
 end else begin q <= d;
 end end endmodule
