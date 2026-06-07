module SignedBitPartSelect_ex1;
 reg signed [7:0] data_s;
 wire [0:0] bit_select_w;
 assign bit_select_w = data_s[0];
 endmodule
