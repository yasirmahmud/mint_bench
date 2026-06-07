module sub_mod (input [3:0] data_in);
    // To resolve W240 (Input declared but not read) and WarnAnalyzeBBox (empty definition)
    // This assignment uses the input internally without affecting external observable behavior.
    wire unused_linter_fix;
    assign unused_linter_fix = |data_in;
endmodule
