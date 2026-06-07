module async_reset_func_ex2(input clk, input rst_n, output reg q);
 function automatic [0:0] rst_n_func;
 input [0:0] reset_in;
 begin rst_n_func = reset_in;
 end endfunction always @(posedge clk or negedge rst_n) begin if (!rst_n_func(rst_n)) begin q <= 1'b0;
 end else begin q <= ~q;
 end end endmodule
