module W468_ex1;
 reg [31:0] wide_bus;
 reg [3:0] narrow_idx;
 wire out_bit;
 assign out_bit = wide_bus[narrow_idx];
 endmodule
