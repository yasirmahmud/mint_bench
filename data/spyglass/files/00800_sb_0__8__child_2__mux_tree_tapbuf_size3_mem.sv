module mux_tree_tapbuf_size3_mem (
    input [0:0] pReset,
    input [0:0] prog_clk,
    input [0:0] ccff_head,
    output [0:0] ccff_tail,
    output [0:1] mem_out
);
    reg [0:1] mem_cfg_reg;

    always @(posedge prog_clk or posedge pReset) begin
        if (pReset) begin
            mem_cfg_reg <= 2'b0;
        end else begin
            // Shift ccff_head into mem_cfg_reg[0], oldest bit shifts out from mem_cfg_reg[1]
            mem_cfg_reg <= {ccff_head[0], mem_cfg_reg[0]};
        end
    end

    assign mem_out = mem_cfg_reg;
    assign ccff_tail = mem_cfg_reg[1]; // The bit that was shifted out (MSB)
endmodule
