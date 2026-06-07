module W486_ex1;
 reg [3:0] data;
 reg [4:0] shift_amount;
 wire [7:0] result;
 assign result = data << shift_amount;
 endmodule
