module sensitive_sig_loop_ex2 (input clk, input rst, output reg [7:0] out_data);
 reg [7:0] loop_sig;
 always @(posedge clk or posedge rst or loop_sig) begin if (rst) begin loop_sig <= 8'b0;
 out_data <= 8'b0;
 end else begin for (int i = 0; i < 2; i = i + 1) begin loop_sig = loop_sig + 1;
 end out_data = loop_sig;
 end end endmodule
