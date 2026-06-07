// Configuration memory for mux_tree_tapbuf_size11 (4 bits)
module mux_tree_tapbuf_size11_mem (
    input pReset,     // Asynchronous reset
    input prog_clk,   // Programming clock
    input ccff_head,  // Configuration chain input
    output ccff_tail, // Configuration chain output
    output [3:0] mem_out // Stored configuration bits for the MUX
);
    reg [3:0] mem_reg;

    always @(posedge prog_clk or posedge pReset) begin
        if (pReset) begin
            mem_reg <= 4'b0000; // Reset memory to all zeros
        end else begin
            // Shift in configuration bit from ccff_head
            mem_reg <= {mem_reg[2:0], ccff_head};
        end
    end

    assign mem_out = mem_reg;   // Output the stored memory bits
    assign ccff_tail = mem_reg[3]; // Output the last bit of the shift register as chain tail
endmodule
