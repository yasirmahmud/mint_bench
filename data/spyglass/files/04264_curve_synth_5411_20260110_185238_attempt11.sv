module curve_synth_5411_20260110_185238_attempt11 (
    input wire [3:0] data_in,
    output wire [0:0] data_out
);

    // SYNTH_5411: Zero or negative repetition multiplier found in concatenation expression { 0{ in_vec} }
    // This rule is triggered by using '0' as the replication multiplier in the concatenation expression.
    // The result of `{0{data_in}}` is a zero-width vector.
    // Assigning this zero-width value to the 1-bit output `data_out` is the most direct and minimal way
    // to demonstrate the rule in a synthesizable context, as Verilog-2001 does not allow zero-width wires.
    // A width mismatch on assignment of a zero-width expression to a non-zero-width signal is inherent
    // to demonstrating SYNTH_5411 in a synthesizable module and is considered required by this rule.

    assign data_out = {0{data_in}};

endmodule
