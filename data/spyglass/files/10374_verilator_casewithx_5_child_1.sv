module test5 (input [3:0] sel, output reg out);
  always @* begin
    casez (sel)
      4'b101?: out = 1;
      default: out = 0;
    endcasez
  end
endmodule
