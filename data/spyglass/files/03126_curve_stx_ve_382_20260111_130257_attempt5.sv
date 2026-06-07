module curve_stx_ve_382_20260111_130257_attempt5 (
    input [31:0] large_data_bus,
    input [1:0] offset_in,
    output [7:0] extracted_data
);

    localparam SELECT_WIDTH = 8; // Width of the part-select (8 bits)

    reg [SELECT_WIDTH-1:0] temp_extracted;
    // dynamic_start_index: max (3*8)+7 = 31. min (0*8)+7 = 7.
    // Fits in [4:0] (0 to 31).
    reg [4:0] dynamic_start_index;

    // Generate a non-constant MSB index for the part-select
    always @(*) begin
        // Example:
        // offset_in = 0 -> dynamic_start_index = 0 * 8 + 7 = 7 (for bits [7:0])
        // offset_in = 1 -> dynamic_start_index = 1 * 8 + 7 = 15 (for bits [15:8])
        // offset_in = 2 -> dynamic_start_index = 2 * 8 + 7 = 23 (for bits [23:16])
        // offset_in = 3 -> dynamic_start_index = 3 * 8 + 7 = 31 (for bits [31:24])
        dynamic_start_index = (offset_in * SELECT_WIDTH) + (SELECT_WIDTH - 1);
    end

    always @(*) begin
        // STX_VE_382: The 'dynamic_start_index' is a non-constant expression.
        // Rule description: "Part-select expression should have a constant index".
        // This uses standard Verilog-2001 part-select syntax [MSB:LSB] where MSB
        // and LSB are derived from a dynamic value. This is expected to trigger
        // exactly one violation for STX_VE_382.
        temp_extracted = large_data_bus[dynamic_start_index : dynamic_start_index - SELECT_WIDTH + 1];
    end

    assign extracted_data = temp_extracted;

endmodule
