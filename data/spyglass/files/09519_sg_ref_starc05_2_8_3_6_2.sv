module star_ex2 (input [1:0] sel_in, output reg out_reg);
 reg [1:0] dc_sig;
 always @(*) begin dc_sig = 2'bxx;
 end always @(*) begin case (dc_sig) 2'b00: out_reg = 1'b0;
 2'b01: out_reg = 1'b1;
 default: out_reg = 1'b0;
 endcase end endmodule
