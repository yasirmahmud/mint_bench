module STARC05_2_8_4_1b_ex2;
 reg [3:0] in;
 reg out;
 always @(*) begin casez (in) 4'b1???: out = 1'b0;
 4'b01??: out = 1'b1;
 4'b00???: out = 1'b0;
 default: out = 1'b0;
 endcase end endmodule
