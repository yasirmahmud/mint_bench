module w468_ex2();
 reg [7:0] data_array [0:15];
 reg [2:0] narrow_index;
 reg [7:0] read_data;
 initial begin narrow_index = 3'd0;
 read_data = data_array[narrow_index];
 end endmodule
