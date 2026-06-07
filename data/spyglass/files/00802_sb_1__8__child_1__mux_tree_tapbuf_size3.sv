// MUX with 3 inputs, 2-bit SRAM select
module mux_tree_tapbuf_size3 (in, sram, sram_inv, out);
  input [0:2] in;
  input [0:1] sram;
  input [0:1] sram_inv; // Unused for functional model
  output out;

  reg out_reg;

  always @* begin
    case (sram)
      2'b00: out_reg = in[0];
      2'b01: out_reg = in[1];
      2'b10: out_reg = in[2];
      default: out_reg = 1'bx;
    endcase
  end

  assign out = out_reg;
endmodule
