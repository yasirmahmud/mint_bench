module w259_ex1 (input clk, input rst, input in1, input in2, output reg out_sig);
 always @(posedge clk) begin if (rst) begin out_sig <= 1'b0;
 end else begin out_sig <= in1;
 end end always @(posedge clk) begin if (!rst) begin out_sig <= in2;
 end end endmodule
