module mux_tree_tapbuf_size10 (
    input [0:9] in,
    input [0:3] sram,
    output [0:3] sram_inv,
    output [0:0] out
);
    assign sram_inv = ~sram; // Invert SRAM bits

    // Interpret sram as a 4-bit selection index.
    // Given sram [0:3] where sram[0] is MSB and sram[3] is LSB,
    // reorder to standard [3:0] for integer interpretation.
    wire [3:0] sram_val = {sram[0], sram[1], sram[2], sram[3]}; 
    integer sel_idx;
    assign sel_idx = sram_val; // Verilog automatically converts bit vector to integer

    // Select input based on sel_idx. If sel_idx is out of bounds (10-15), output a default value.
    assign out = (sel_idx < 10) ? in[sel_idx] : 1'b0;

endmodule
