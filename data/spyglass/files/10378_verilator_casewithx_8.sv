module test8 (input [0:0] sel, output reg out);
  always @* begin
    casez (sel)
      1'bx: out = 1;
      default: out = 0;
    endcase
  end
endmodule
