module sop_expression(input a,b,c,d, output out);
mux4_1 mux(.(s[0])(b),
           .(s[1])(a),
           .(in[0])(d),
           .(in[1])((~c)&(~d)),
           .(in[2])(c&d),
           .(in[3])(1'b1),
            .out(out));
endmodule
