module sim_synth_mismatch_ex2 (input wire clk, input wire rst_n, output reg out_reg);
 reg my_var;
 initial begin my_var = 1'b0;
 end always @(posedge clk or negedge rst_n) begin if (!rst_n) begin out_reg <= 1'b0;
 my_var <= 1'b0;
 end else begin out_reg <= my_var;
 my_var <= ~my_var;
 end end endmodule
