module curve_starc05_2_10_3_2a_20260111_184314_081622_w7792_attempt10(
    input wire clk,
    input wire rst_n,
    input wire enable_in,      // 1-bit control signal
    output reg out_reg         // 1-bit status register
);

    parameter DATA_WIDTH = 5;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_reg <= 1'b0;
        end else begin
            // Original: out_reg <= enable_in && {DATA_WIDTH{1'b0}};
            // The logical AND expression 'enable_in && {DATA_WIDTH{1'b0}}' always evaluates to 1'b0,
            // because '{DATA_WIDTH{1'b0}}' (which is 5'b00000) is logically false.
            // Regardless of 'enable_in', the result of the logical AND will be 1'b0.
            // Directly assigning 1'b0 preserves the functional behavior and resolves both violations:
            // STARC05-2.1.4.5 (use bit-wise operator instead of logical operator '&&')
            // STARC05-2.10.3.2a (Operand bit-width mismatch for operator '&&')
            out_reg <= 1'b0;
        end
    end

endmodule
