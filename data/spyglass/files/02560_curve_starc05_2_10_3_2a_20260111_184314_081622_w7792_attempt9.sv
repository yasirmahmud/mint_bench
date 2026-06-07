module curve_starc05_2_10_3_2a_20260111_184314_081622_w7792_attempt9(
    input clk,
    input rst_n,
    input enable_input,      // 1-bit control signal
    output reg output_status // 1-bit status register
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            output_status <= 1'b0;
        end else begin
            // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'
            // 'enable_input' is 1-bit, '5'd15' is a 5-bit constant.
            // This triggers the width mismatch for the '&&' operator.
            output_status <= enable_input && 5'd15;
        end
    end

endmodule
