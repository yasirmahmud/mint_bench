module test13 (input [7:0] sel, output reg out);
  always @* begin
    casez (sel)
      8'h0?: out = 1;
      default: out = 0;
    endcasez
  end
endmodule
