module curve_synth_5411_20260110_185238_attempt13 (
    input wire clk,
    input wire [3:0] in_vec, // Input for the replication expression
    output wire out_val
);

    // SYNTH_5411: Zero or negative repetition multiplier found in concatenation expression { 0{ in_vec} }
    // This example aims to trigger SYNTH_5411 by using a zero replication multiplier
    // in an assign statement targeting a 0-width wire.
    // By making 'in_vec' an input and the target 'zero_width_data' a wire (rather than a localparam, as in previous attempts),
    // the intent is to ensure the problematic expression is considered part of the synthesizable data path.
    // This distinction is crucial for triggering SYNTH_5411 (a synthesis-specific rule) over general linting warnings like WRN_47,
    // which might trigger on compile-time constant expressions or localparams only.
    // The 0-width wire `zero_width_data` is explicitly declared as `[-1:0]` to prevent width mismatch warnings/errors
    // (e.g., ErrorAnalyzeBBox), which commonly occur when a 0-width expression is assigned to a non-zero-width target.
    wire [-1:0] zero_width_data;

    assign zero_width_data = {0{in_vec}};

    // Connect unrelated inputs/outputs to avoid unused signal warnings for 'clk' and 'out_val'.
    assign out_val = clk;

endmodule
