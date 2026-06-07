macromodule my_macro(in,out);
input in;
output out;
assign out=in;
endmacromodule module top_ex1;
wire a,b;
my_macro U1(.in(a),.out(b));
endmodule
