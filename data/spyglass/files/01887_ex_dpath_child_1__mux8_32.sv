module mux8_32(out, in7, in6, in5, in4, in3, in2, in1, in0, sel);
  output [31:0] out;
  input  [31:0] in7, in6, in5, in4, in3, in2, in1, in0;
  input  [3:0]  sel;
  reg    [31:0] out_reg;
  always @(*) begin
    case (sel)
      4'b0000: out_reg = in0;
      4'b0001: out_reg = in1;
      4'b0010: out_reg = in2;
      4'b0011: out_reg = in3;
      4'b0100: out_reg = in4;
      4'b0101: out_reg = in5;
      4'b0110: out_reg = in6;
      4'b0111: out_reg = in7;
      default: out_reg = in0; // Default case
    endcase
  end
  assign out = out_reg;
endmodule
