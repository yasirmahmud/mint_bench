module mux_tree_tapbuf_size3 (
    input [2:0] in,
    input [1:0] sram,
    output [1:0] sram_inv,
    output out
);
    assign sram_inv = ~sram;
    
    // Simple 3-input multiplexer
    // Assuming sram[1:0] selects in[0] through in[2]
    assign out = (sram == 2'b00) ? in[0] :
                 (sram == 2'b01) ? in[1] :
                 (sram == 2'b10) ? in[2] : 1'b0;
endmodule
