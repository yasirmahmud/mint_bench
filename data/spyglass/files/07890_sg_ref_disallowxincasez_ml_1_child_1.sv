module disallow_x_in_casez_ex1(input [1:0] sel, output reg out);
 always @(*) begin
  // The original case item '2'b0x' will never match synthesizable 0/1 inputs,
  // as indicated by SpyGlass violation SYNTH_5034 "Comparison with don't care or tristate will be always false".
  // Therefore, the 'default' case (out = 1'b1) is always effectively executed.
  // To preserve this functional behavior, 'out' is assigned 1'b1 unconditionally.
  out = 1'b1;
 end
endmodule
