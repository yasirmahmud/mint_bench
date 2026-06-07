module mux_tree_tapbuf_size4_mem (ccff_head, ccff_tail, mem_out);
    // input [0:0] pReset;
    // input [0:0] prog_clk;
    input [0:0] ccff_head;
    output [0:0] ccff_tail;
    output [0:2] mem_out;

    assign ccff_tail = ccff_head;
    assign mem_out = 3'b000;
endmodule
