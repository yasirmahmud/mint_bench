module star_c02_2_8_3_7_ex1 (output reg out_data);
reg [1:0] select_sig;
assign select_sig = 2'b1x;
always @(*) begin casex (select_sig) 2'b00: out_data = 1'b0;
 2'b01: out_data = 1'b1;
 default: out_data = 1'b0;
 endcasex end endmodule
