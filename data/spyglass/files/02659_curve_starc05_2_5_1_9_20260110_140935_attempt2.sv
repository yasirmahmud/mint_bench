module curve_starc05_2_5_1_9_20260110_140935_attempt2 (
    input wire sel,
    input wire [1:0] data_in,
    output tri [1:0] tri_out,
    output reg [1:0] out_reg
);

    // Create a 2-bit tri-state output signal
    assign tri_out = sel ? data_in : 2'bz;

    // Use the 2-bit tri-state output in a casez statement selection expression.
    // This directly triggers the STARC05-2.5.1.9 violation.
    // Using a multi-bit tri_out aims to generate 2 occurrences as requested in the prompt summary.
    always @(*) begin
        casez (tri_out) // Violation occurs here, potentially for each bit
            2'b00: out_reg = 2'b00;
            2'b01: out_reg = 2'b01;
            2'b10: out_reg = 2'b10;
            2'b11: out_reg = 2'b11;
            default: out_reg = 2'bx; // Handles 'x' or 'z' on tri_out, prevents latches
        endcase
    end

endmodule
