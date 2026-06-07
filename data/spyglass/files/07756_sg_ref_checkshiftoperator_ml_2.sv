module check_shift_ex2;
 signed [7:0] s_val;
 reg [7:0] result;
 assign result = s_val[7:0] >> 1;
 endmodule
