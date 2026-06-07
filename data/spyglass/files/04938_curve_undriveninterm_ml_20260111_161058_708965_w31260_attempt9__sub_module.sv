module sub_module (
    input wire [1023:0] MEM,
    output wire [31:0] sub_out
);
    // Extract the 32nd 32-bit word (0-indexed), which is MEM[1023:992].
    wire [31:0] mem_word_31;
    assign mem_word_31 = MEM[1023:992];

    // The rule targets b05.MEM[31][31:6].
    // This corresponds to mem_word_31[31:6] within this submodule.
    // These are the bits from the parent module's 'mem_to_b05[1023:998]' which are undriven.
    wire [25:0] undriven_target_slice_in_submodule;
    assign undriven_target_slice_in_submodule = mem_word_31[31:6]; // This slice is undriven.

    // Use the undriven target slice directly to ensure its undefined state propagates
    // and triggers an ERROR-level violation, as the output will be 'X'.
    // Pad with zeros to match the 32-bit output width (26 bits + 6 bits = 32 bits).
    assign sub_out = {6'b0, undriven_target_slice_in_submodule};

endmodule
