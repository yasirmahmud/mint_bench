module curve_w224_20260111_224708_685342_w32456_attempt11 (
    input wire clk,
    input wire rst_n,
    input wire enable_in,
    output reg flag_out
);

    reg [3:0] counter_reg; // Multi-bit register

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter_reg <= 4'd0;
            flag_out <= 1'b0;
        end else begin
            if (enable_in) begin
                counter_reg <= counter_reg + 4'd1;
                // W224 violation: Multi-bit expression 'counter_reg' found when one-bit expression expected
                if (counter_reg) begin // Using multi-bit 'counter_reg' as a boolean condition
                    flag_out <= 1'b1;
                end else begin
                    flag_out <= 1'b0;
                end
            end else begin
                // Maintain current state to avoid latches for flag_out
                flag_out <= flag_out;
            end
        end
    end

endmodule
