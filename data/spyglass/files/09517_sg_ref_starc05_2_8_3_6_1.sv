module star_c05_2_8_3_6_ex1 (output reg out_sig);
 reg [1:0] sel_dc;
 always @(*) begin sel_dc = 2'bxx;
 case (sel_dc) 2'b00: out_sig = 1'b0;
 2'b01: out_sig = 1'b1;
 default: out_sig = 1'b0;
 endcase end endmodule
