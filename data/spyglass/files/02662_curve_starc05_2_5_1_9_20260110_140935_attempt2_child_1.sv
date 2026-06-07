module curve_starc05_2_5_1_9_20260110_140935_attempt2 (
    input wire sel,
    input wire [1:0] data_in,
    output tri [1:0] tri_out,
    output reg [1:0] out_reg
);

    // Create a 2-bit tri-state output signal
    assign tri_out = sel ? data_in : 2'bz;

    // The STARC05-2.5.1.9 violation is resolved by not using the tri-state output
    // 'tri_out' directly in the selection expression of the casez statement.
    // Instead, we use the 'sel' signal to determine the source of 'out_reg'.
    // If 'sel' is asserted, 'out_reg' follows 'data_in' (which is what 'tri_out' would be).
    // If 'sel' is deasserted, 'out_reg' becomes '2'bx', which matches the behavior
    // when 'tri_out' is '2'bz' and is caught by the original casez's default branch.
    always @(*) begin
        if (sel) begin
            // When sel is high, tri_out reflects data_in
            // Use a simple case statement as data_in is not tri-state and we handle 'x' with default
            case (data_in)
                2'b00: out_reg = 2'b00;
                2'b01: out_reg = 2'b01;
                2'b10: out_reg = 2'b10;
                2'b11: out_reg = 2'b11;
                default: out_reg = 2'bx; // Handles 'x' on data_in if it occurs
            endcase
        end else begin
            // When sel is low, tri_out is 2'bz
            // In this scenario, the original casez would hit the default branch,
            // assigning 2'bx to out_reg.
            out_reg = 2'bx;
        end
    end

endmodule
