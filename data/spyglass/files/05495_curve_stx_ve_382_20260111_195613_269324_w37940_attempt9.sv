module curve_stx_ve_382_20260111_195613_269324_w37940_attempt9 (
    input clk,
    input rst_n,
    input [15:0] large_data_in,
    input [3:0] dynamic_lsb_idx, // A non-constant index for LSB
    output reg [7:0] data_segment_out
);

    reg [15:0] internal_buffer;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            internal_buffer <= 16'h0;
            data_segment_out <= 8'h0;
        end else begin
            internal_buffer <= large_data_in;

            // STX_VE_382 violation: Part-select expression uses a non-constant LSB index and thus
            // also a non-constant MSB index. 'dynamic_lsb_idx' is an input, making
            // 'dynamic_lsb_idx' and 'dynamic_lsb_idx + 7' non-constant expressions.
            // This should trigger exactly one violation for STX_VE_382.
            data_segment_out <= internal_buffer[dynamic_lsb_idx + 7 : dynamic_lsb_idx];
        end
    end

endmodule
