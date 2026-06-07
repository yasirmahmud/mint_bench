module sub_module #(parameter P = 0);
    // P is a simple integer parameter, typically expected to be a scalar or single value.
    // Connecting a concatenation (aggregate) to it is considered an incompatible connection.
    wire unused_dummy_signal; // Added to resolve WarnAnalyzeBBox: Design Unit 'sub_module' has empty definition
    assign unused_dummy_signal = 1'b0; // Added to further ensure the module is not considered empty by the linter.
endmodule
