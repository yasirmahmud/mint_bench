module W486_ex2;
 reg [3:0] data_in;
 reg [5:0] shift_val;
 wire [9:0] result;
 assign result = data_in << shift_val;
 endmodule
