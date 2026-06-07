module curve_stx_ve_382_20260111_195613_269324_w37940_attempt7 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input [1:0] select_idx,
    output reg [3:0] data_out
);

    reg [7:0] data_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_reg <= 8'h0;
            data_out <= 4'h0;
        end else begin
            data_reg <= data_in;

            // STX_VE_382 violation: Part-select expression uses non-constant indices.
            // Both 'select_idx + 3' and 'select_idx' are non-constant, triggering the rule.
            // With select_idx [1:0] (0-3), the part-select ranges from data_reg[3:0] to data_reg[6:3],
            // which is always a 4-bit slice perfectly within data_reg[7:0] and matches data_out[3:0] width.
            data_out <= data_reg[select_idx + 3 : select_idx];
        end
    end

endmodule
