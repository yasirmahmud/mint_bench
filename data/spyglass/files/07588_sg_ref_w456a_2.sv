module W456a_ex2 (input wire clk, input wire reset, input wire data_in, input wire unused_sig, output reg data_out);
 always @(data_in or unused_sig or reset) begin if (reset) begin data_out = 1'b0;
 end else begin data_out = data_in;
 end end endmodule
