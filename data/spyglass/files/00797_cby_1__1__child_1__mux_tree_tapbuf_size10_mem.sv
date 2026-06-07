module mux_tree_tapbuf_size10_mem (
    input pReset,
    input prog_clk,
    input ccff_head,
    output ccff_tail,
    output [0:3] mem_out
);
    reg [0:3] sram_reg;
    
    always @(posedge prog_clk or posedge pReset) begin
        if (pReset) begin
            sram_reg <= 4'b0000;
        end else begin
            sram_reg[0] <= ccff_head;
            sram_reg[1] <= sram_reg[0];
            sram_reg[2] <= sram_reg[1];
            sram_reg[3] <= sram_reg[2];
        end
    end

    assign mem_out = sram_reg;
    assign ccff_tail = sram_reg[3];
endmodule
