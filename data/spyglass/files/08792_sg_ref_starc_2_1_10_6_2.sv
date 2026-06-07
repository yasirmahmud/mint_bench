module star_2_1_10_6_ex2 (output reg out);
 localparam [1:0] MY_SEL = 2'b01;
 localparam MY_IN1 = 1'b1;
 localparam MY_IN2 = 1'b0;
 always @() begin case (MY_SEL) 2'b00: out = MY_IN1;
 2'b01: out = MY_IN2;
 default: out = 1'b0;
 endcase end endmodule
