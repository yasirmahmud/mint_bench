module NoOthersInAsgn_ML_ex1 (input wire clk);
 reg [7:0] data_vec;
 always @(posedge clk) begin data_vec[3:0] <= {4{1'b1}};
 end endmodule
