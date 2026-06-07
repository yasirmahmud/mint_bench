module sub_mod_for_ex2 (input [7:0] p_in);
    // To resolve W240 and WarnAnalyzeBBox, p_in is assigned to a local wire
    // This ensures p_in is "read" and the module is not empty.
    wire [7:0] p_in_dummy_use;
    assign p_in_dummy_use = p_in;
 endmodule
