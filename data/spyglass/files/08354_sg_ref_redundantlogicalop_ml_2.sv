module redundant_op_ex2();
wire a,b,out;
assign out = (a||b) || (a||b);
endmodule
