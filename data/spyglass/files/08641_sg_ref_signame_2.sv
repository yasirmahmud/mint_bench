module sig_name_violation_ex2(input clk, output reg out);
 wire mySignal;
 assign mySignal = clk;
 always @(posedge clk) out <= mySignal;
 endmodule
