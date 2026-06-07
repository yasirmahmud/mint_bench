module uniq8char_ex1(clk, in_val_a, out_val_a);
 input clk;
 input in_val_a;
 output out_val_a;
 reg out_val_a;
 reg out_val_b;
 always @(posedge clk) begin out_val_a <= in_val_a;
 out_val_b <= in_val_a;
 end endmodule
