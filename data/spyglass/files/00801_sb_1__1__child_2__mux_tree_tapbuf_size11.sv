// These modules are added to resolve SpyGlass ErrorAnalyzeBBox violations.
// They define the behavior of the multiplexer and configuration memory cells.

// Mux with 11 inputs and 4 select bits
module mux_tree_tapbuf_size11 (
    input [10:0] in,       // 11 data inputs
    input [3:0] sram,      // 4-bit SRAM configuration (select lines)
    output [3:0] sram_inv, // Inverted SRAM configuration (for complementary select lines)
    output out             // Single output of the multiplexer
);
    assign sram_inv = ~sram; // Generate inverted select signals

    reg out_reg;
    always @(*) begin
        case (sram)
            4'b0000: out_reg = in[0];
            4'b0001: out_reg = in[1];
            4'b0010: out_reg = in[2];
            4'b0011: out_reg = in[3];
            4'b0100: out_reg = in[4];
            4'b0101: out_reg = in[5];
            4'b0110: out_reg = in[6];
            4'b0111: out_reg = in[7];
            4'b1000: out_reg = in[8];
            4'b1001: out_reg = in[9];
            4'b1010: out_reg = in[10];
            default: out_reg = 1'b0; // Default to 0 for unselected/invalid SRAM values
        endcase
    end
    assign out = out_reg;
endmodule
