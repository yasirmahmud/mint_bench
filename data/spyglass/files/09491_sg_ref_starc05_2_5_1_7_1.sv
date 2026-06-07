module tristate_if_ex1 (input in, input en, output out);
 assign out = en ? in : 1'bz;
 always @(*) begin if (out) begin end end endmodule
