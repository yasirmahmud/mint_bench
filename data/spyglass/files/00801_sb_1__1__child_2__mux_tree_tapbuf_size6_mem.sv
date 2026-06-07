// Configuration memory for mux_tree_tapbuf_size6 (3 bits)
module mux_tree_tapbuf_size6_mem (
    input pReset,
    input prog_clk,
    input ccff_head,
    output ccff_tail,
    output [2:0] mem_out
);
    reg [2:0] mem_reg;

    always @(posedge prog_clk or posedge pReset) begin
        if (pReset) begin
            mem_reg <= 3'b000;
        end else begin
            mem_reg <= {mem_reg[1:0], ccff_head};
        end
    end

    assign mem_out = mem_reg;
    assign ccff_tail = mem_reg[2];
endmodule
