module w316_ex1();
 reg [7:0] narrow_reg = 8'hFF;
 // 'int_var' and its assignment have been removed as it was set but never read (W528).
 // The initial block has been replaced by an inline initialization for 'narrow_reg'
 // to resolve the 'initial block ignored for synthesis' violation (SYNTH_5143).
endmodule
