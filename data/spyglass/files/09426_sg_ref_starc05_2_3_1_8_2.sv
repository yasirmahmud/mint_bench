module my_module_ex2 (input clk, input rst, input d, output reg q);
 always begin wait (clk);
 if (rst) q <= 1'b0;
 else q <= d;
 end endmodule
