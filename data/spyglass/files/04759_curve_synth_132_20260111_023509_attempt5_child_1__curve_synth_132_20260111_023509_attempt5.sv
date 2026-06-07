// Top module: curve_synth_132_20260111_023509_attempt5
// Triggers SYNTH_132 by using a hierarchical reference in a parameter override during instantiation.
module curve_synth_132_20260111_023509_attempt5 (
    input wire clk,
    input wire [7:0] top_input,
    output wire [7:0] top_output
);

    wire [7:0] internal_source_out;
    wire [7:0] internal_sink_out;

    // Instantiate the parameter source module. Its CONST_PARAM is 8.
    param_source_module u_param_source (
        .clk(clk),
        .in_data(top_input),
        .out_data(internal_source_out)
    );

    // SYNTH_132 violation: Hierarchical reference 'u_param_source.CONST_PARAM'
    // is used to override the 'SINK_WIDTH' parameter of 'u_param_sink'.
    // This is not supported for synthesis.
    param_sink_module #(
        .SINK_WIDTH(u_param_source.CONST_PARAM) // <-- SYNTH_132 violation occurs here
    ) u_param_sink (
        .clk(clk),
        .data_in(internal_source_out),
        .data_out(internal_sink_out)   // Fixed: Changed from .out_data to .data_out to match param_sink_module's port name
    );

    // Connect the final output to avoid unused signals and ensure connectivity
    assign top_output = internal_sink_out;

endmodule
