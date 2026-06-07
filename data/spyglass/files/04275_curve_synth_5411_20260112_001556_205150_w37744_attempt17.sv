module curve_synth_5411_module (
    input wire [3:0] source_data,
    output wire [-1:0] zero_output // Declare a zero-width output to match the zero-width expression
);

    // SYNTH_5411 violation: Zero or negative repetition multiplier found in concatenation expression
    // The multiplier '0' causes the concatenation to have zero width.
    assign zero_output = {0{source_data}};

    // All inputs and outputs are used, and widths are explicitly managed.
    // The zero-width output declaration avoids width mismatch warnings (like WRN_24) 
    // and inferred zero-width net warnings (like WRN_47).

endmodule
