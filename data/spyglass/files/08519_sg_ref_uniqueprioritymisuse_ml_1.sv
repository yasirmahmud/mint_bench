module unique_priority_misuse_ex1();
 reg dff;
 wire clk, din, reset;
 always @ (posedge clk) unique if (reset) begin dff <= 0;
 end else begin dff <= din;
 end endmodule
