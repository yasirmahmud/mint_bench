module event_control_rhs_ex2(input clk, input rst_n, input data_in, output reg data_out);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) data_out <= 1'b0;
 else data_out <= @(posedge clk) data_in;
 end endmodule
