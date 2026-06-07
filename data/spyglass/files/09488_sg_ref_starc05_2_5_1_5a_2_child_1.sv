module multi_driver_ex2 (in1, in2, clk, out_sig);
 input in1, in2, clk;
 output reg out_sig;

 always @(posedge clk) begin
  out_sig <= in1; // Using non-blocking assignment and selecting 'in1' to resolve multiple drivers
 end

 endmodule
