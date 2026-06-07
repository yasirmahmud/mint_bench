module memberwidthmismatch_ml_ex1;
 reg [4:0] A;
 reg [2:0] B, C;
 initial begin B = 3'd1;
 C = 3'd2;
 end assign A = B + C;
 endmodule
