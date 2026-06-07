module decoder_4to16(
	input [`D_SIZE-1:0] in,
	output reg [(1<<`D_SIZE)-1:0] out
	);
always @(*) begin
	out = '0;
	out[in] = 1'b1;
end
endmodule
