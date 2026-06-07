module signed_sys_func_usage_ex1;
 wire [7:0] a;
 wire signed [7:0] b;
 assign a = 8'hFF;
 assign b = $signed(a);
 endmodule
