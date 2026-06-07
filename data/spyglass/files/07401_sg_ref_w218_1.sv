module W218_ex1 (input [1:0] data, output reg out);
 always @(posedge data) begin out <= data[0];
 end endmodule
