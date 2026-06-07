module tristate_mixed_ex2 (input in1, input in2, input enb, output out_logic, output out_tri);
 reg out_logic, out_tri;
 always @(in1 or in2 or enb) begin out_tri = enb ? in1 : 1'bz;
 out_logic = in1 & in2;
 end endmodule
