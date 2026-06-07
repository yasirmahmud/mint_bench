// Definition for mux_tree_tapbuf_size12_mem
module mux_tree_tapbuf_size12_mem (
    input [0:0] pReset,
    input [0:0] prog_clk,
    input [0:0] ccff_head,
    output [0:0] ccff_tail,
    output [0:3] mem_out
);

    reg [0:3] mem_data;

    always @(posedge prog_clk or posedge pReset) begin
        if (pReset) begin
            mem_data <= 4'b0000; // Reset configuration memory to all zeros
        end else begin
            // Implement a 4-bit shift register for configuration memory.
            // Assuming ccff_head feeds mem_data[0] and mem_data[3] outputs to ccff_tail.
            // Left shift: mem_data[0] gets new head, mem_data[3] is shifted out
            // Corrected part-select to avoid STX_VE_491 violation while preserving functionality.
            mem_data <= {mem_data[2], mem_data[1], mem_data[0], ccff_head}; // Left shift: mem_data[0] gets new head, mem_data[3] is shifted out
        end
    end

    // Output the stored configuration data to control the multiplexer
    assign mem_out = mem_data;
    // Output the last bit of the shift register for chaining to the next memory module
    assign ccff_tail = mem_data[3];

endmodule
