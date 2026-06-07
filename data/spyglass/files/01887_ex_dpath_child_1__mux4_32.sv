module mux4_32(out, in3, in2, in1, in0, sel);
  output [31:0] out;
  input  [31:0] in3, in2, in1, in0;
  input  [1:0]  sel;
  reg    [31:0] out_reg;
  always @(*) begin
    case (sel)
      2'b00: out_reg = in0;
      2'b01: out_reg = in1;
      2'b10: out_reg = in2;
      2'b11: out_reg = in3;
      default: out_reg = in0; // Default case
    endcase
  end
  assign out = out_reg;
endmodule
