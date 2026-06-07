module mux_tree_tapbuf_size4 (in, sram, out);
    input [0:3] in; // 4 inputs
    input [0:2] sram; // 3 select bits, sram[1:0] likely selects, sram[2] likely unused or part of complex logic
    // input [0:2] sram_inv;
    output out;

    reg output_reg;
    always @(*) begin
        case (sram) // Using full sram width and providing default for unused select states
            3'b000: output_reg = in[0];
            3'b001: output_reg = in[1];
            3'b010: output_reg = in[2];
            3'b011: output_reg = in[3];
            default: output_reg = 1'b0; // Handles sram values 3'b100 to 3'b111
        endcase
    end
    assign out = output_reg;
endmodule
