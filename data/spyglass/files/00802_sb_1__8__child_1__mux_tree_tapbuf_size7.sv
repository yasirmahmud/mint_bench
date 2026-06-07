// MUX with 7 inputs, 3-bit SRAM select
module mux_tree_tapbuf_size7 (in, sram, sram_inv, out);
  input [0:6] in;
  input [0:2] sram;
  input [0:2] sram_inv; // Unused for functional model
  output out;

  reg out_reg;

  always @* begin
    case (sram)
      3'b000: out_reg = in[0];
      3'b001: out_reg = in[1];
      3'b010: out_reg = in[2];
      3'b011: out_reg = in[3];
      3'b100: out_reg = in[4];
      3'b101: out_reg = in[5];
      3'b110: out_reg = in[6];
      default: out_reg = 1'bx;
    endcase
  end

  assign out = out_reg;
endmodule
