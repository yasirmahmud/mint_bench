module curve_stx_ve_382_20260111_195613_269324_w37940_attempt6 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    input [2:0] select_idx,
    output reg [3:0] data_out
);

    reg [31:0] storage_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            storage_reg <= 32'h0;
            data_out <= 4'h0;
        end else begin
            storage_reg <= {storage_reg[23:0], data_in};
            // STX_VE_382 violation: Part-select expression uses non-constant indices
            data_out <= storage_reg[select_idx + 3 : select_idx];
        end
    end

endmodule
