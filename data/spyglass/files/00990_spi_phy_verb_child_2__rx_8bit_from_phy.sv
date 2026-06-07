module rx_8bit_from_phy (
	input				clock,
	input				rst_n,
	input				start,
	input				finish,
	input				rx_data,
	input				rx_valid,
	output				stream_sof,
	output	[7:0]		stream_data,
	output				stream_vld,
	output				stream_eof
);
    reg [7:0]   data_buffer_reg;
    reg [2:0]   bit_count_reg;
    reg         stream_vld_reg;
    reg         stream_sof_reg;
    reg         stream_eof_reg;

    always @(posedge clock or negedge rst_n) begin
        if (!rst_n) begin
            data_buffer_reg <= 8'h00;
            bit_count_reg <= 3'b000;
            stream_vld_reg <= 1'b0;
            stream_sof_reg <= 1'b0;
            stream_eof_reg <= 1'b0;
        end else begin
            stream_vld_reg <= 1'b0; // Clear by default
            stream_sof_reg <= 1'b0; // Clear by default
            stream_eof_reg <= 1'b0; // Clear by default

            if (start) begin
                bit_count_reg <= 3'b000;
                stream_sof_reg <= 1'b1; // Mark start of frame
            end

            if (rx_valid) begin
                data_buffer_reg <= {data_buffer_reg[6:0], rx_data};
                bit_count_reg <= bit_count_reg + 1'b1;

                if (bit_count_reg == 3'd7) begin // After 8 bits (0 to 7)
                    stream_vld_reg <= 1'b1;
                end
            end

            if (finish) begin
                stream_eof_reg <= 1'b1; // Mark end of frame
            end
        end
    end

    assign stream_sof = stream_sof_reg;
    assign stream_data = data_buffer_reg;
    assign stream_vld = stream_vld_reg;
    assign stream_eof = stream_eof_reg;
endmodule
