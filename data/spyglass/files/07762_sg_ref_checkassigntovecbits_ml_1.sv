module CheckAssignToVecBits_ex1;
 reg [7:0] data_out;
 reg [3:0] in1;
 reg [3:0] in2;
 always @(*) begin data_out = {in1, in2};
 end endmodule
