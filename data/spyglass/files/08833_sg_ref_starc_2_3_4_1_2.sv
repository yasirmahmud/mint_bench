module star_2_3_4_1_ex2 (in, out, clk);
 input in, clk;
 output out;
 reg out;
 initial begin out = 1'b0;
 end always @(posedge clk) out <= in;
 endmodule
