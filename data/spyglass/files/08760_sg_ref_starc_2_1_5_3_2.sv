module stac_2_1_5_3_ex2;
 reg [1:0] a;
 reg b;
 always @(*) begin if (a) b = 1;
 else b = 0;
 end endmodule
