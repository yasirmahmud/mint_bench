module star_ex1 (input clk, input data_in, output reg q1, output reg q2);
 always @(posedge clk) begin q1 <= data_in;
 end always @(posedge data_in) begin q2 <= clk;
 end endmodule
