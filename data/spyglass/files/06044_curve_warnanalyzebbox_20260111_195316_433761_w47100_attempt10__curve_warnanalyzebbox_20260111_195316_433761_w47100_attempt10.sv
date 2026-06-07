// Top module to instantiate the empty sub_module.
module curve_warnanalyzebbox_20260111_195316_433761_w47100_attempt10 (
    output wire top_output_status
);

    // Internal wire to connect to the blackbox module's output.
    wire blackbox_output_internal;

    // Instantiate the 'sub_module' which has an empty definition.
    // This instantiation itself does not trigger a warning, but the definition of 'sub_module' does.
    sub_module u_empty_instance (
        .out_signal(blackbox_output_internal)
    );

    // Drive the top-level output from the blackbox module's output.
    // This ensures 'blackbox_output_internal' is used and avoids W240 (unused signal).
    assign top_output_status = blackbox_output_internal;

endmodule
