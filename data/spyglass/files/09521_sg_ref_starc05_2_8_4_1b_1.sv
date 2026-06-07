module star_c05_2_8_4_1b_ex1(input [3:0] in, output reg out);
always @* begin casex(in) 4'b1???: out = 1;
 4'b01??: out = 0;
 4'b00???: out = 1;
 default: out = 0;
 endcase end endmodule
