module reset_name_violation_ex2(input clk, input my_reset, input data_in, output reg data_out);
 always @(posedge clk or negedge my_reset) begin if (!my_reset) begin data_out = 1'b0;
 end else begin data_out = data_in;
 end end endmodule
