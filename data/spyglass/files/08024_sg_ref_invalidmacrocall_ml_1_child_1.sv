module InvalidMacroCall_ML_ex1;
 `define MY_MACRO 1;
 reg a = `MY_MACRO; // Removed space in macro call (addressing InvalidMacroCall-ML) and used direct initialization for 'reg' to resolve SYNTH_5143.
 wire dummy_use_a = a; // Added a dummy wire to read 'a' and resolve W528 (Variable 'a' set but not read).
endmodule
