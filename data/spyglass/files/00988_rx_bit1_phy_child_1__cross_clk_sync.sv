module cross_clk_sync #(
	parameter int LAT = 1,   // Latency in clock cycles
	parameter int DSIZE = 1  // Data size
)(
	input			clk,
	input			rst_n,
	input	[DSIZE-1:0]	d,
	output	[DSIZE-1:0]	q
);

generate
    if (LAT == 0) begin : gen_lat0
        assign q = d; // Combinational path
    end else if (LAT == 1) begin : gen_lat1
        reg [DSIZE-1:0] q_reg;
        always @(posedge clk or negedge rst_n) begin
            if (~rst_n) begin
                q_reg <= '0;
            end else begin
                q_reg <= d;
            end
        end
        assign q = q_reg;
    end else begin : gen_lat_gt1
        // For general case, a shift register for LAT > 1
        reg [DSIZE-1:0] q_shift [0:LAT-1]; // Note: Array declaration [MSB:LSB] or [0:N-1]
        always @(posedge clk or negedge rst_n) begin
            if (~rst_n) begin
                for (int i=0; i<LAT; i++) q_shift[i] <= '0;
            end else begin
                q_shift[0] <= d;
                for (int i=1; i<LAT; i++) q_shift[i] <= q_shift[i-1];
            end
        end
        assign q = q_shift[LAT-1];
    end
endgenerate

endmodule
