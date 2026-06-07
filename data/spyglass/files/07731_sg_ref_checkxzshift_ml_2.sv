module check_xz_shift_ex2(input [7:0] data, output [7:0] result);
 reg [2:0] shift_amount;
 initial begin shift_amount = 3'bx;
 end assign result = data << shift_amount;
 endmodule
