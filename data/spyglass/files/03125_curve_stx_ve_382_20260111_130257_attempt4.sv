module curve_stx_ve_382_20260111_130257_attempt4 (
    input [31:0] large_data_bus,
    input [3:0] offset_in,
    output [7:0] extracted_data
);

    localparam SELECT_WIDTH = 8;

    reg [SELECT_WIDTH-1:0] temp_extracted;
    reg [4:0] dynamic_start_index; // Capable of holding up to 31 (for offset_in=15 -> index=30)

    // Derive a non-constant index from the input
    always @(*) begin
        // The multiplication ensures 'dynamic_start_index' is not a constant value
        // Max offset_in=15, so dynamic_start_index max is 30. Valid for 32-bit bus.
        dynamic_start_index = offset_in * 2;
    end

    always @(*) begin
        // STX_VE_382: The 'dynamic_start_index' is a non-constant expression.
        // Rule description: "Part-select expression should have a constant index".
        // This SystemVerilog indexed part-select (end-index with decrementing width) uses a non-constant index,
        // which is expected to trigger exactly one violation.
        temp_extracted = large_data_bus[dynamic_start_index :- SELECT_WIDTH];
    end

    assign extracted_data = temp_extracted;

endmodule
