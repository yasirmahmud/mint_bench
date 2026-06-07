module my_module_ex2(input clk, input reset, input start_op, input op_done, output reg timeout_flag);
 always @(posedge clk or posedge reset) begin if (reset) begin timeout_flag <= 1'b0;
 end else if (start_op) begin fork begin wait(op_done);
 end begin #100;
 end join_any if (!op_done) begin timeout_flag <= 1'b1;
 end end end endmodule
