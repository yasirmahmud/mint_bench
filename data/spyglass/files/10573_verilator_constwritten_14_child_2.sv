module const_write_14;
  // Original: string NAME = "user";
  // SpyGlass SYNTH_5260 (STRING data type not supported) and
  // SYNTH_89 (Initial Assignment at Declaration ignored) violations addressed.
  // Changed to a synthesizable fixed-width register. "admin" has 5 characters (5*8 = 40 bits).
  reg [39:0] NAME; 

  initial begin
    // The initial declaration 'string NAME = "user";' is now removed as
    // its value would be immediately overwritten and is ignored by synthesis.
    // The 'case(1) ... endcase' structure simplifies to setting NAME to "admin".
    // This will set the power-on or reset value for the 'NAME' register in hardware.
    case(1)
      1: NAME = "admin"; // SystemVerilog allows direct assignment of string literals to bit vectors.
    endcase
  end
endmodule
