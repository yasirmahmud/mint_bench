module detect_formality_aborts_ex1 (input [7:0] in_a, output [7:0] out_b);
 reg [7:0] x_val;
 always @* begin x_val = 8'bxxxx_xxxx;
 end assign out_b = x_val + in_a;
 endmodule
