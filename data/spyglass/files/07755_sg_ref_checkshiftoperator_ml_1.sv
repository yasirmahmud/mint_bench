module CheckShiftOperator_ex1;
 reg signed [7:0] data_in;
 reg [7:0] data_out;
 assign data_out = data_in >> 1;
 endmodule
