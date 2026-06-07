module top_module;
    // STX_VE_299 violation 1: Incompatible connection to parameter 'P' resolved by providing an integer literal.
    // Here, a 2-bit concatenation {1'b1, 1'b0} (which is 2'b10, or decimal 2) is assigned to the scalar parameter P.
    sub_module #(.P(2)) inst_sub_1 ();

    // STX_VE_299 violation 2: Incompatible connection to parameter 'P' resolved by providing an integer literal.
    // Another instance, assigning a 4-bit concatenation {2'b10, 2'b01} (which is 4'b1001, or decimal 9) to P.
    sub_module #(.P(9)) inst_sub_2 ();
endmodule
