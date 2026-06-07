module sub_module_w156_attempt11 (
    input [3:0] standard_data_bus_in, // Port declared with MSB:LSB indexing
    output [3:0] data_processed_out
);

    assign data_processed_out = standard_data_bus_in;

endmodule
