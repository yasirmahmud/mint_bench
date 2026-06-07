// Mux with 6 inputs and 3 select bits
module mux_tree_tapbuf_size6 (
    input [5:0] in,
    input [2:0] sram,
    output [2:0] sram_inv,
    output out
);
    assign sram_inv = ~sram;

    reg out_reg;
    always @(*) begin
        case (sram)
            3'b000: out_reg = in[0];
            3'b001: out_reg = in[1];
            3'b010: out_reg = in[2];
            3'b011: out_reg = in[3];
            3'b100: out_reg = in[4];
            3'b101: out_reg = in[5];
            default: out_reg = 1'b0;
        endcase
    end
    assign out = out_reg;
endmodule
