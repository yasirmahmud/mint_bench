module curve_stx_ve_361_20260111_230514_542320_w28836_attempt11 (
    output wire out_data
);

    reg my_net; // Changed from wire to reg to allow procedural assignments

    // This initial block now correctly performs a procedural assignment to the reg 'my_net'.
    initial begin
        my_net = 1'b0; // VIOLATION FIXED: 'my_net' is now a reg, allowing procedural assignment
    end

    // Assign 'my_net' to 'out_data' to prevent 'my_net' from being flagged as unused.
    assign out_data = my_net;

endmodule
