module star_c05_2_9_1_2a_ex1(input [7:0] data_in);
 reg [3:0] i;
 reg [7:0] result;
 initial begin result = 8'h00;
 for (i = data_in[3:0]; i < 10; i = i + 1) begin result = result + 1;
 end end endmodule
