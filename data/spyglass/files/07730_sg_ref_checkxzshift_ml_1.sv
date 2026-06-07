module CheckXZShift_ML_ex1;
 reg [3:0] data_in;
 reg [1:0] shift_amount;
 wire [3:0] data_out;
 initial begin shift_amount = 2'bx;
 data_in = 4'b1010;
 end assign data_out = data_in << shift_amount;
 endmodule
