// Helper MUX modules definitions
// MUX with 2 inputs, 2-bit SRAM select
module mux_tree_tapbuf_size2 (in, sram, sram_inv, out);
  input [0:1] in;
  input [0:1] sram;
  input [0:1] sram_inv; // Unused for functional model
  output out;

  reg out_reg;

  always @* begin
    case (sram)
      2'b00: out_reg = in[0];
      2'b01: out_reg = in[1];
      default: out_reg = 1'bx;
    endcase
  end

  assign out = out_reg;
endmodule
