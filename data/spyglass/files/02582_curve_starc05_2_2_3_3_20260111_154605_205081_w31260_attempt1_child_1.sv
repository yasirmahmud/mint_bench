module curve_starc05_2_2_3_3_20260111_154605_205081_w31260_attempt1 (
    input wire clk,
    input wire reset,
    input wire data_in_a,
    input wire data_in_b,
    output reg my_flop
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        my_flop <= 1'b0;
    end else begin
        // The last assignment to 'my_flop' in the original code determined its functional behavior.
        // To resolve multiple assignment violations while preserving that behavior, we keep only the last assignment.
        my_flop <= data_in_b;
    end
end

endmodule
