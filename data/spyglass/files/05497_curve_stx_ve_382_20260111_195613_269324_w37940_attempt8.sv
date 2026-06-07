module curve_stx_ve_382_20260111_195613_269324_w37940_attempt8 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input select_idx, // 1-bit index
    output reg [1:0] data_out
);

    reg [7:0] data_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_reg <= 8'h0;
            data_out <= 2'h0;
        end else begin
            data_reg <= data_in;

            // STX_VE_382 violation: Part-select expression uses a non-constant MSB index.
            // The LSB index '4' is a constant, but the MSB index 'select_idx + 4' is non-constant
            // because 'select_idx' is an input. This should trigger exactly one violation for STX_VE_382.
            data_out <= data_reg[select_idx + 4 : 4];
        end
    end

endmodule
