module SignedUnsignedExpr_ex2;
 wire signed [7:0] s_val = 8'sd5;
 wire [7:0] u_val = 8'd10;
 wire signed [8:0] sum_result;
 assign sum_result = s_val + u_val;
 endmodule
