module multi_driver_ex2 (in1, in2, clk, out_sig);
 input in1, in2, clk;
 output reg out_sig;
 always @(posedge clk) out_sig = in1;
 always @(posedge clk) out_sig = in2;
 endmodule
