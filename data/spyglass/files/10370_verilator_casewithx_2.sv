module test2 (input [2:0] sel, output reg out);
  always @* begin
    case (sel)
      3'b1x0: out = 1;
      default: out = 0;
    endcase
  end
endmodule
