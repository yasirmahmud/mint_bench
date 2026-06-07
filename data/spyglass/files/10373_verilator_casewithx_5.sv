module test5 (input [3:0] sel, output reg out);
  always @* begin
    case (sel)
      4'b101x: out = 1;
      default: out = 0;
    endcase
  end
endmodule
