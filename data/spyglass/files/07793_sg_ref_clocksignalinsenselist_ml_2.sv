module clock_sense_list_ex2 (input clk, input rst, input data_in, input trigger_sig, output reg data_out);
 always @(posedge clk or posedge rst or posedge trigger_sig) begin if (rst) data_out <= 1'b0;
 else data_out <= data_in;
 end endmodule
