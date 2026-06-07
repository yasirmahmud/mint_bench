module STARC02_2_8_3_4a_ex1();
 reg my_sig;
 reg [1:0] sel;
 always @(*) begin case (sel) 2'b00: my_sig = 1'b0;
 default: my_sig = 1'bx;
 endcase end always @(*) begin if (my_sig) begin end end endmodule
