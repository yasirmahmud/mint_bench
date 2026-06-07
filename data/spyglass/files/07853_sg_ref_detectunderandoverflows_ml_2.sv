module overflow_padding_ex2;
 reg [7:0] small_data;
 reg [15:0] large_data;
 initial begin small_data = 8'hFF;
 large_data = small_data;
 end endmodule
