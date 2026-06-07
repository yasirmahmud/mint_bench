module ZeroReplicationMultiplier_ex1();
wire [1:0] out;
assign out = {1'b1, {0{1'b0}}, 1'b1};
endmodule
