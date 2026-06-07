// Definition for mux_tree_tapbuf_size12
module mux_tree_tapbuf_size12 (
    input [0:11] in,
    input [0:3] sram,
    output [0:3] sram_inv,
    output [0:0] out
);
    // Drive sram_inv as the inverse of sram
    assign sram_inv = ~sram;

    // 12-to-1 multiplexer with 4-bit select (sram)
    reg [0:0] out_reg;
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
            4'b1011: out_reg = in[11];
            default: out_reg = 1'b0; // Default for unused select lines
        endcase
    end
    assign out = out_reg;

endmodule
