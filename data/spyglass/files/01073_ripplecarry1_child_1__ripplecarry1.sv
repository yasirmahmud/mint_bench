module ripplecarry1(input wire [1:0] a, b, input wire cin, output reg [1:0] S, output reg [1:0] co);
  fulladder n1(a[0], b[0], cin, S[0], co[0]);
  fulladder n2(a[1], b[1], co[0], S[1], co[1]);
endmodule
