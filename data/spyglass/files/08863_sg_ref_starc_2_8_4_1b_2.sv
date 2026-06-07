module starc_2_8_4_1b_ex2;
 reg [2:0] in;
 reg out;
 always @(*) begin casex(in) 3'b1??: out = 1'b1;
 3'b01?: out = 1'b0;
 3'b00??: out = 1'b1;
 default: out = 1'b0;
 endcase end endmodule
