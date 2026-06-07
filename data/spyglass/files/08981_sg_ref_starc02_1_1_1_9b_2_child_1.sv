module long_port_name_ex2(input this_is_a_very_long_port_name_that_exceeds_16_chars);
    // Assign the input to an internal signal to resolve W240 (input declared but not read).
    wire unused_input_read_wire;
    assign unused_input_read_wire = this_is_a_very_long_port_name_that_exceeds_16_chars;
endmodule
