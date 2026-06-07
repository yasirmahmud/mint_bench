module test13 (input [7:0] sel, output reg out);
  always @* begin
    case (sel)
      8'h0X: out = 1;
      default: out = 0;
    endcase
  end
endmodule
