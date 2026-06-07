module DisallowForceOnPortConn_ML_ex1 (input in_a, output out_b);
 assign out_b = in_a;
 initial begin #10 force out_b = 1'b0;
 end endmodule
