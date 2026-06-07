module curve_stx_ve_382_20260111_130257_attempt3 (
    input [15:0] data_in,
    input [2:0] start_index_in, // Max value 7 (0-7). Allows [7:+8] -> [7:14].
    output [7:0] data_out
);

reg [7:0] temp_val;

always @(*) begin
    // STX_VE_382: The 'start_index_in' is a non-constant expression (an input port).
    // Rule description: "Part-select expression should have a constant index".
    // This use of indexed part-select (SystemVerilog-style with :+) is intended to trigger exactly one violation.
    // The bounds are carefully chosen to avoid STX_VE_002 (index out of bounds).
    temp_val = data_in[start_index_in :+ 8];
end

assign data_out = temp_val;

endmodule
