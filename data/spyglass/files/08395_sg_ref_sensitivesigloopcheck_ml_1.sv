module sensitive_sig_loop_check_ex1(input clk, input rst, output reg [7:0] data_out);
 reg [7:0] sensitive_var;
 always @(posedge clk or posedge rst or sensitive_var) begin if (rst) begin sensitive_var <= 8'h00;
 data_out <= 8'h00;
 end else begin integer i;
 for (i = 0; i < 5; i = i + 1) begin sensitive_var = sensitive_var + 1;
 data_out = sensitive_var;
 end end end endmodule
