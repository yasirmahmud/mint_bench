module test11 (input [4:0] sel, output reg out);
  always @* begin
    case (sel)
      5'b1x01x: out = 1;
      default: out = 0;
    endcase
  end
endmodule
