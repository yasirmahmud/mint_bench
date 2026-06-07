module disallow_casex_ex2 (input [1:0] sel, output reg out);
  always @(*) begin
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      default: out = 1'bx;
    end case;
  end

  always @(*) begin
    casex (sel)
      2'b0x: out = 1'b0;
      2'b1x: out = 1'b1;
      default: out = 1'bx;
    endcasex;
  end
endmodule
