module mux_tree_tapbuf_size2_mem (ccff_head, ccff_tail, mem_out);
    // input [0:0] pReset;
    // input [0:0] prog_clk;
    input [0:0] ccff_head;
    output [0:0] ccff_tail;
    output [0:1] mem_out;

    assign ccff_tail = ccff_head;
    assign mem_out = 2'b00;
endmodule
