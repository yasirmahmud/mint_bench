module w442c_ex1 (input clk, input reset_n, input data_in, input some_other_condition, output reg q);
 always @(posedge clk or negedge reset_n) begin if (reset_n && some_other_condition) begin q <= 1'b0;
 end else begin q <= data_in;
 end end endmodule
