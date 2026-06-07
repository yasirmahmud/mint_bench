module check_shift_ex2;
 wire signed [7:0] s_val; // Corrected: Declares 's_val' as a signed wire
 reg [7:0] result;
 assign result = s_val[7:0] >> 1;
 endmodule
