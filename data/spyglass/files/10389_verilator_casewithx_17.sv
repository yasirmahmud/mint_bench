module test17 (input [2:0] sel, output reg out);
  localparam LP = 3'b0x1;
  always @* begin
    case (sel)
      LP: out = 1;
      default: out = 0;
    endcase
  end
endmodule
