module same_signal_assign_ex2 (input a, input b, output reg out);
 always @* begin out <= a;
 out <= b;
 end endmodule
