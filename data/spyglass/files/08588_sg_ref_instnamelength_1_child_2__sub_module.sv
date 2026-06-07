module sub_module();
    localparam DUMMY_PARAM = 1; // Added to make module definition non-empty and resolve WarnAnalyzeBBox
    // Added a dummy wire to resolve "empty definition" warning
    wire dummy_signal;
 endmodule
