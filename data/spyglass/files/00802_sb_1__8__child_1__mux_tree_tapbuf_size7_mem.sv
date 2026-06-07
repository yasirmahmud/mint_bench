// Memory for 7-bit SRAM select
module mux_tree_tapbuf_size7_mem (pReset, prog_clk, ccff_head, ccff_tail, mem_out);
  input pReset;
  input prog_clk;
  input ccff_head;
  output ccff_tail;
  output [0:2] mem_out; // 3 bits for SRAM select

  reg [0:2] mem_reg;

  always @(posedge prog_clk or posedge pReset) begin
    if (pReset) begin
      mem_reg <= 3'b0;
    end else begin
      mem_reg[0] <= ccff_head;
      mem_reg[1] <= mem_reg[0];
      mem_reg[2] <= mem_reg[1];
    end
  end

  assign mem_out = mem_reg;
  assign ccff_tail = mem_reg[2];
endmodule
