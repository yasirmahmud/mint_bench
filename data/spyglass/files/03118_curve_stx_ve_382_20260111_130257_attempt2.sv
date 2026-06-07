module curve_stx_ve_382_20260111_130257_attempt2 (
    input [31:0] data_in,
    output [7:0] data_out
);

parameter ENTRY_WIDTH = 8;
parameter NUM_ENTRIES = 4;

reg [NUM_ENTRIES * ENTRY_WIDTH - 1 : 0] data_bus; // data_bus is 32 bits
reg [ENTRY_WIDTH - 1 : 0] temp_out; // temp_out is 8 bits
integer i;

// Drive data_bus combinationaly to avoid unused signal for data_in and ensure synthesizable RTL
always @(*) begin
    data_bus = data_in;
end

always @(*) begin
    // Initialize temp_out to avoid latches if not all paths assign to it.
    // In a combinational always block with a for loop, the final assignment to temp_out by the loop determines its value.
    temp_out = '0;

    // Iterate through entries. The part-select uses 'i', which is an integer loop variable.
    // This makes the indices non-constant, triggering STX_VE_382.
    for (i = 0; i < NUM_ENTRIES; i = i + 1) begin
        // STX_VE_382: Part-select expression should have a constant index
        // Both bounds depend on 'i', which is a non-constant loop variable.
        // Based on provided context examples, this structure should trigger exactly one STX_VE_382.
        temp_out = data_bus[i * ENTRY_WIDTH + ENTRY_WIDTH - 1 : i * ENTRY_WIDTH];
    end
end

assign data_out = temp_out;

endmodule
