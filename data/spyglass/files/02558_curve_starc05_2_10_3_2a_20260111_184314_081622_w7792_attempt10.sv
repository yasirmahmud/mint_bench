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
            // STARC05-2.10.3.2a: Operand bit-width mismatch for operator '&&'
            // 'enable_in' is 1-bit, '{DATA_WIDTH{1'b0}}' (5'd0) is a 5-bit constant.
            out_reg <= enable_in && {DATA_WIDTH{1'b0}};
        end
    end

endmodule
