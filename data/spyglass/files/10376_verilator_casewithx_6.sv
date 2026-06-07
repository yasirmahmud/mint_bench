module test6 (input [1:0] sel, output reg out);
  always @* begin
    casez (sel)
      2'b0x: out = 1;
      default: out = 0;
    endcase
  end
endmodule
