module multi_driver_ex1 (in1, in2, clk, out);
 input in1, in2, clk;
 output reg out;
 always @(posedge clk) out <= in1;
 endmodule
