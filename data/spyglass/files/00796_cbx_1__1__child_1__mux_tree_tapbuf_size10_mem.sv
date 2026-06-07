module mux_tree_tapbuf_size10_mem (
    input [0:0] pReset,
    input [0:0] prog_clk,
    input [0:0] ccff_head,
    output [0:0] ccff_tail,
    output [0:3] mem_out
);
    // SRAM register to store 4 configuration bits
    reg [0:3] sram_reg;

    // Output the stored SRAM value
    assign mem_out = sram_reg;
    // The last bit in the shift register chain is the tail
    assign ccff_tail = sram_reg[3];

    always @(posedge prog_clk or posedge pReset) begin
        if (pReset) begin
            // Reset all SRAM bits to 0
            sram_reg <= 4'b0000;
        end else begin
            // Shift data: ccff_head feeds into sram_reg[0] (MSB),
            // and existing bits shift right (towards LSB)
            sram_reg <= {ccff_head, sram_reg[0], sram_reg[1], sram_reg[2]};
        end
    end
endmodule
