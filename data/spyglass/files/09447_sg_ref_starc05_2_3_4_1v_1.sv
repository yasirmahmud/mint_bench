module my_module_ex1 (input clk, d, output q);
 reg q_ff = 1'b0;
 assign q = q_ff;
 always @(posedge clk) begin q_ff <= d;
 end endmodule
