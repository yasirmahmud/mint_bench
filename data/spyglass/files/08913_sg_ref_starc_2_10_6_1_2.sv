module loss_of_carry_ex2;
 reg [2:0] data_in1;
 reg [2:0] data_in2;
 reg [2:0] sum_out;
 always @(*) begin sum_out = data_in1 + data_in2;
 end endmodule
