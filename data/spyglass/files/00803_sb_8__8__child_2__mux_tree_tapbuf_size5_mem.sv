module mux_tree_tapbuf_size5_mem (
    input pReset,
    input prog_clk,
    input ccff_head,
    output ccff_tail,
    output [2:0] mem_out
);
    reg [2:0] sram_storage;

    always @(posedge prog_clk or posedge pReset) begin
        if (pReset) begin
            sram_storage <= 3'b000; // Reset all SRAM bits to 0
        end else begin
            // Shift in ccff_head, and propagate existing bits
            sram_storage[0] <= ccff_head;
            sram_storage[1] <= sram_storage[0];
            sram_storage[2] <= sram_storage[1];
        end
    }

    assign mem_out = sram_storage;
    assign ccff_tail = sram_storage[2];
endmodule
