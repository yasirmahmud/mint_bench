// Mux with 9 inputs and 4 select bits
module mux_tree_tapbuf_size9 (
    input [8:0] in,
    input [3:0] sram,
    output [3:0] sram_inv,
    output out
);
    assign sram_inv = ~sram;

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
            default: out_reg = 1'b0;
        endcase
    end
    assign out = out_reg;
endmodule
