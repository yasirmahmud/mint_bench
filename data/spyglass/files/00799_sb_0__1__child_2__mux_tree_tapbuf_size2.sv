module mux_tree_tapbuf_size2 (in, sram, out);
    input [0:1] in; // 2 inputs
    input [0:1] sram; // 2 select bits, sram[0] likely selects, sram[1] likely unused
    // input [0:1] sram_inv;
    output out;

    assign out = sram[0] ? in[1] : in[0]; // Simple 2:1 mux with sram[0] as select
endmodule
