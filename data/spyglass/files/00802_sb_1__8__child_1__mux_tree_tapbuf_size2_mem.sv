// Helper Memory modules definitions
// Memory for 2-bit SRAM select
module mux_tree_tapbuf_size2_mem (pReset, prog_clk, ccff_head, ccff_tail, mem_out);
  input pReset;
  input prog_clk;
  input ccff_head;
  output ccff_tail;
  output [0:1] mem_out; // 2 bits for SRAM select

  reg [0:1] mem_reg;

  always @(posedge prog_clk or posedge pReset) begin
    if (pReset) begin
      mem_reg <= 2'b0;
    end else begin
      mem_reg[0] <= ccff_head;
      mem_reg[1] <= mem_reg[0];
    end
  end

  assign mem_out = mem_reg;
  assign ccff_tail = mem_reg[1];
endmodule
