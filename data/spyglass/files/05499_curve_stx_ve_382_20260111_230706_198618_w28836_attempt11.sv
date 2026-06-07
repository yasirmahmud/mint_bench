module curve_stx_ve_382_20260111_230706_198618_w28836_attempt11 (
    input wire clk,
    input wire rst_n,
    input wire enable,
    input wire [7:0] data_in,
    input wire [3:0] base_idx, // Non-constant index for part-select
    output reg [7:0] data_out
);

    reg [31:0] storage_reg; // Data register, 32-bit wide

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            storage_reg <= 32'h0;
            data_out <= 8'h0;
        end else if (enable) begin
            // Update storage_reg to avoid unused signal warning and make it functional
            // Shift in new data and keep old data
            storage_reg <= {storage_reg[23:0], data_in};

            // STX_VE_382 violation: Part-select expression uses non-constant indices.
            // Both 'base_idx + 7' (MSB) and 'base_idx' (LSB) are non-constant expressions.
            // The slice width is (base_idx + 7) - base_idx + 1 = 8, which is constant
            // and matches 'data_out' width, thereby avoiding width mismatch issues.
            data_out <= storage_reg[base_idx + 7 : base_idx];
        end
    end

endmodule
