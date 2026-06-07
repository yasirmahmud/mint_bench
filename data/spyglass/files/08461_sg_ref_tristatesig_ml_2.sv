module tristate_sig_ex2 (input clk, input rst, input in1, output reg r1);
 always @(posedge clk) begin if (rst == 1'b0) begin r1 <= 1'bz;
 end else begin r1 <= in1;
 end end endmodule
