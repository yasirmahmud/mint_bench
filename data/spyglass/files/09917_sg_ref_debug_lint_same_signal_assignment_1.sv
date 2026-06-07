module same_signal_assign_ex1 (input wire clk, input wire rst_n, input wire in1, input wire in2, output reg out_reg);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin out_reg <= 1'b0;
 end else begin out_reg <= in1;
 out_reg <= in2;
 end end endmodule
