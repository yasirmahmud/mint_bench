module mux_tree_tapbuf_size5 (in, sram, out);
    input [0:4] in; // 5 inputs
    input [0:2] sram; // 3 select bits
    // input [0:2] sram_inv;
    output out;

    reg output_reg;
    always @(*) begin
        case (sram)
            3'b000: output_reg = in[0];
            3'b001: output_reg = in[1];
            3'b010: output_reg = in[2];
            3'b011: output_reg = in[3];
            3'b100: output_reg = in[4];
            default: output_reg = 1'b0; // Handle 3'b101, 3'b110, 3'b111 or other unexpected states
        endcase
    end
    assign out = output_reg;
endmodule
