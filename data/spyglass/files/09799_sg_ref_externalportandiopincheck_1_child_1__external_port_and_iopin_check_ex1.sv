module external_port_and_iopin_check_ex1 (
    inout ext_io_port,
    input io_data_out,      // New port: Data to be driven onto the external port
    input io_output_enable  // New port: Output enable (0 = drive, 1 = tristate)
);
    // Renamed from internal_io_wire to internal_io_data_in to reflect its new role as an input signal.
    wire internal_io_data_in; 

    // Instantiate the MY_IO_CELL. It connects its PAD to internal_io_data_in.
    // MY_IO_CELL is assumed to be a conceptual buffer or physical pad connection.
    MY_IO_CELL i_io_cell (.PAD(internal_io_data_in));

    // Fix for CombLoop: Implemented proper bi-directional logic for ext_io_port.
    // The 'ext_io_port' is driven by 'io_data_out' when 'io_output_enable' is active (0),
    // otherwise, it is tri-stated (1'bz).
    assign ext_io_port = (io_output_enable == 1'b0) ? io_data_out : 1'bz;

    // 'internal_io_data_in' now continuously reflects the current value of 'ext_io_port'.
    // This signal serves as the input data from the pad for internal logic.
    // This breaks the combinational loop by clearly separating output driving and input sensing paths.
    assign internal_io_data_in = ext_io_port;
endmodule
