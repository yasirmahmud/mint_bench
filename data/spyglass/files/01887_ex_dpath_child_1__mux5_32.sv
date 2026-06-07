module mux5_32(out, in4, in3, in2, in1, in0, sel);
  output [31:0] out;
  input  [31:0] in4, in3, in2, in1, in0;
  input  [2:0]  sel;
  reg    [31:0] out_reg;
  always @(*) begin
    case (sel)
      3'b000: out_reg = in0;
      3'b001: out_reg = in1;
      3'b010: out_reg = in2;
      3'b011: out_reg = in3;
      3'b100: out_reg = in4;
      default: out_reg = in0; // Default case
    endcase
  end
  assign out = out_reg;
endmodule
