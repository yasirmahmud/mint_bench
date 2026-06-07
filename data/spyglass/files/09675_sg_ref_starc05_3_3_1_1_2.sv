module star_c05_3_3_1_1_ex2 (input in_data, output out_q);
 reg internal_clk;
 reg q_reg;
 assign out_q = q_reg;
 initial begin internal_clk = 1'b0;
 end always #10 internal_clk = ~internal_clk;
 always @(posedge internal_clk) begin q_reg <= in_data;
 end endmodule
