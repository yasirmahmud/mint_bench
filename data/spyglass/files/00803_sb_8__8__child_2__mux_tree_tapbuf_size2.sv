module mux_tree_tapbuf_size2 (
    input [1:0] in,
    input [1:0] sram,
    output [1:0] sram_inv,
    output out
);
    assign sram_inv = ~sram;
    
    // Simple 2-input multiplexer
    // Assuming sram[0] is the select bit
    assign out = sram[0] ? in[1] : in[0];
endmodule
