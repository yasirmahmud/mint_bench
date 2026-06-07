// MUX with 11 inputs, 4-bit SRAM select
module mux_tree_tapbuf_size11 (in, sram, sram_inv, out);
  input [0:10] in;
  input [0:3] sram;
  input [0:3] sram_inv; // Unused for functional model
  output out;

  reg out_reg;

  always @* begin
    case (sram)
      4'b0000: out_reg = in[0];
      4'b0001: out_reg = in[1];
      4'b0010: out_reg = in[2];
      4'b0011: out_reg = in[3];
      4'b0100: out_reg = in[4];
      4'b0101: out_reg = in[5];
      4'b0110: out_reg = in[6];
      4'b0111: out_reg = in[7];
      4'b1000: out_reg = in[8];
      4'b1001: out_reg = in[9];
      4'b1010: out_reg = in[10];
      default: out_reg = 1'bx;
    endcase
  end

  assign out = out_reg;
endmodule
