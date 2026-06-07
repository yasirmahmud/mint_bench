module SigVarInit_ex1 (
  output reg [7:0] my_signal
);

  // SpyGlass SYNTH_5143 violation fixed by moving initial value
  // from initial block to the reg declaration, making it synthesizable.
  reg [7:0] my_signal = 8'h00;

endmodule
