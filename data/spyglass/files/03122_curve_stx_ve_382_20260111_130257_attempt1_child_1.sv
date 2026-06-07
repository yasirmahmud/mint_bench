module curve_stx_ve_382_20260111_130257_attempt1 (
    input [7:0] data_in,
    input [2:0] start_index, // Non-constant index
    output [3:0] data_out
);

reg [15:0] my_reg;

always @(*) begin
    my_reg = {8'h00, data_in}; // Use data_in to avoid unused signal warning
end

// STX_VE_382: Part-select expression should have a constant index
// Original: assign data_out = my_reg[start_index + 3 : start_index];
// Fix: Use a right-shift followed by a constant part-select to achieve dynamic indexing.
assign data_out = (my_reg >> start_index)[3:0];

endmodule
