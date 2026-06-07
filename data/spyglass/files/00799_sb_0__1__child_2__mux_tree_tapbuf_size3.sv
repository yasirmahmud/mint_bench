module mux_tree_tapbuf_size3 (in, sram, out);
    input [0:2] in; // 3 inputs
    input [0:1] sram; // 2 select bits
    // input [0:1] sram_inv;
    output out;

    reg output_reg;
    always @(*) begin
        case (sram)
            2'b00: output_reg = in[0];
            2'b01: output_reg = in[1];
            2'b10: output_reg = in[2];
            default: output_reg = 1'b0; // Handle 2'b11 or other unexpected states
        endcase
    end
    assign out = output_reg;
endmodule
