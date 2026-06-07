module memberwidthmismatch_ml_ex2;
 reg [4:0] A;
 reg [2:0] B, C, D;
 reg result;
 initial begin A = 5'd10;
 B = 3'd2;
 C = 3'd1;
 D = 3'd3;
 result = (A + B) == (C + D);
 end endmodule
