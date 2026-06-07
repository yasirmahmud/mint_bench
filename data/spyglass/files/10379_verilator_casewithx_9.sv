module test9 (input [3:0] sel, output reg out);
  always @* begin
    casez (sel)
      4'hX: out = 1;
      default: out = 0;
    endcase
  end
endmodule
