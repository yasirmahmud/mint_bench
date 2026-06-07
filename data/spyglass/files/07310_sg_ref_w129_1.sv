module W129_ex1(input in, output out, input [7:0] delay_val);
 assign #delay_val out = in;
 endmodule
