module star_ex2(input clk, rst, in1, in2, input [1:0] data_in, output reg out1, out2, output [1:0] data_out);
 always @(posedge clk or posedge rst) begin if (rst) begin out1 <= 1'b0;
 out2 <= 1'b0;
 data_out <= 2'b00;
 end else begin out1 <= in1;
 out2 <= in2;
 data_out <= data_in;
 end end endmodule
