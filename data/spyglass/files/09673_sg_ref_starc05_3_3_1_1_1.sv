module starc05_3_3_1_1_ex1 (input in_data, output out_q);
 reg internal_clk;
 reg ff_q;
 initial begin internal_clk = 1'b0;
 end always @(posedge internal_clk) begin ff_q <= in_data;
 end assign out_q = ff_q;
 endmodule
