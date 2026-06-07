module test16 (input [1:0] sel, output reg out);
  parameter P = 2'b1x;
  always @* begin
    casez (sel)
      P: out = 1;
      default: out = 0;
    endcase
  end
endmodule
