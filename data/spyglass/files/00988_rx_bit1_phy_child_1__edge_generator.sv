module edge_generator #(
	parameter string MODE = "NORMAL" // Dummy parameter to resolve linting
)(
	input			clk,
	input			rst_n,
	input			in,
	output			raising,
	output			falling
);

reg		in_q1, in_q2;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		in_q1 <= 1'b0;
		in_q2 <= 1'b0;
	end else begin
		in_q1 <= in;
		in_q2 <= in_q1;
	end
end

assign raising = (in_q1 == 1'b1) && (in_q2 == 1'b0);
assign falling = (in_q1 == 1'b0) && (in_q2 == 1'b1);

endmodule
