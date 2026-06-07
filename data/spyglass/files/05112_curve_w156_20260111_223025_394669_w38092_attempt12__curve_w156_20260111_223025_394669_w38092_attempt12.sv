module curve_w156_20260111_223025_394669_w38092_attempt12 (
    input [7:0] master_data_bus,
    output [7:0] processed_data_bus
);

    wire [7:0] internal_data_msb_lsb; // MSB:LSB indexed wire
    wire [7:0] result_data_msb_lsb;

    assign internal_data_msb_lsb = master_data_bus;
    assign processed_data_bus = result_data_msb_lsb;

    // Instantiate data_processor
    // Port 'data_in' in 'data_processor' is declared as [0:7] (LSB:MSB).
    // The connected net 'internal_data_msb_lsb' in the parent module is declared as [7:0] (MSB:LSB).
    // This difference in indexing style for the same bus width causes the W156 violation.
    data_processor u_processor (
        .data_in (internal_data_msb_lsb), // W156 violation expected here for 'data_in'
        .data_out (result_data_msb_lsb)
    );

endmodule
