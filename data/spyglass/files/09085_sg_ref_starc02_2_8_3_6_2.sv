module star_c02_2_8_3_6_ex2 (output reg out_sig);
 reg [1:0] sel_dc;
 always @(*) begin sel_dc = 2'bx;
 case (sel_dc) 2'b00: out_sig = 1'b0;
 2'b01: out_sig = 1'b1;
 2'b10: out_sig = 1'b0;
 default: out_sig = 1'b1;
 endcase end endmodule
