module multi_assign_ml_ex1 (input clk, input rst_n, input [7:0] data_in, output reg [7:0] data_out);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin data_out <= 8'h00;
 end else begin data_out <= data_in;
 data_out <= data_in + 1;
 end end endmodule
