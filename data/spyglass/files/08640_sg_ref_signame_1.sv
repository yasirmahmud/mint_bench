module SigName_ex1(input clk, output reg out);
 wire mySignal;
 assign mySignal = clk;
 always @(posedge clk) out <= mySignal;
 endmodule
