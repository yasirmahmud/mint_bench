module curve_starc05_2_1_5_3_20260111_081759_attempt2 (
    input clk,
    input rst,
    input enable_operation,
    output reg [3:0] status_value, // Multi-bit output
    output reg data_out_valid
);

reg [3:0] count_reg; // Multi-bit signal, similar to 'count' in rule description

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count_reg <= 4'h0;
        status_value <= 4'h0;
        data_out_valid <= 1'b0;
    end else begin
        if (enable_operation) begin
            count_reg <= count_reg + 1;
        end else begin
            count_reg <= 4'h0; // Reset count if not enabled
        end

        // STARC05-2.1.5.3 violation: 'count_reg' (multi-bit) is used directly as a conditional.
        // The Verilog LRM states that for a conditional expression in an 'if' statement,
        // if the expression is multi-bit, it is implicitly converted to a 1-bit value
        // (0 if all bits are 0, 1 otherwise). This rule flags the original multi-bit expression.
        if (count_reg) begin // Target line for STARC05-2.1.5.3
            status_value <= count_reg; // Ensure 'count_reg' is used
            data_out_valid <= 1'b1;
        end else begin
            status_value <= 4'hF; // Example values
            data_out_valid <= 1'b0;
        end
    end
end

endmodule
