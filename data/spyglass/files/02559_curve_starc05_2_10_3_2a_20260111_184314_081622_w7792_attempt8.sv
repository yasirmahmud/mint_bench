module curve_starc05_2_10_3_2a_20260111_184314_081622_w7792_attempt8(
    input clk,
    input rst_n, // Active low reset
    input request_valid, // 1-bit control signal
    input [7:0] address_field, // multi-bit data/address field
    output reg operation_active_reg // 1-bit status register
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            operation_active_reg <= 1'b0;
        end else begin
            // Violation target: logical AND (&&) with operand bit-width mismatch
            // 'request_valid' is 1-bit, 'address_field' is 8-bit.
            operation_active_reg <= request_valid && address_field;
        end
    end

endmodule
