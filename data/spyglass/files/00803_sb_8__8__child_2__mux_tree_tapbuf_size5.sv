module mux_tree_tapbuf_size5 (
    input [4:0] in,
    input [2:0] sram,
    output [2:0] sram_inv,
    output out
);
    assign sram_inv = ~sram;
    
    // Simple 5-input multiplexer
    // Assuming sram[0] is LSB for selection
    assign out = (sram == 3'b000) ? in[0] :
                 (sram == 3'b001) ? in[1] :
                 (sram == 3'b010) ? in[2] :
                 (sram == 3'b011) ? in[3] :
                 (sram == 3'b100) ? in[4] : 1'b0;
endmodule
