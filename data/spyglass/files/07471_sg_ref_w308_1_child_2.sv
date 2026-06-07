module W308_ex1 (
    output integer i_val
);
    // The original 'real r_val' declaration and its assignment in the 'initial' block
    // have been removed. 'real' types are not synthesizable, and 'initial' blocks
    // are ignored for synthesis, leading to SYNTH_5143 violation.
    // The functional behavior of 'i_val' being initialized to the integer part of 3.14 (which is 3)
    // is preserved using a synthesizable register declaration with an initial value.
    integer i_val_reg = 3;

    // The variable 'i_val_reg' is now driven to an output port 'i_val'.
    // This resolves the W528 violation ('variable set but not read') by making the value externally accessible.
    assign i_val = i_val_reg;

endmodule
