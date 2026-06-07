module starc_2_8_3_4b_ex1;
 reg [1:0] sel;
 reg data_in;
 reg data_out;
 reg x_signal;
 always @(*) begin x_signal = 1'b0;
 case (sel) 2'b00: x_signal = 1'b0;
 2'b01: x_signal = 1'b1;
 default: x_signal = 1'bx;
 endcase end assign data_out = x_signal ? data_in : ~data_in;
 endmodule
