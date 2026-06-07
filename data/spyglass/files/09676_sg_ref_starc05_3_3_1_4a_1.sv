module my_module_ex1 (input clk, input d, output q);
 reg q_reg;
 wire internal_async_rst;
 assign internal_async_rst = 1'b1;
 always @(posedge clk or posedge internal_async_rst) begin if (internal_async_rst) begin q_reg <= 1'b0;
 end else begin q_reg <= d;
 end end assign q = q_reg;
 endmodule
