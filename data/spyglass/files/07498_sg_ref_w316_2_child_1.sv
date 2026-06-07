module W316_ex2 (
    input clk,
    input rst_n // Active low reset
);
    reg [7:0] m;

    // The initial block is replaced with synthesizable reset logic to resolve SYNTH_5143.
    // m is initialized to 8'hAA on reset, preserving the intended initial value.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            m <= 8'hAA;
        end
        // No other logic for m in this simple example, so it will retain its reset value.
    end

    // The 'integer n' declaration and 'n = m' assignment are removed.
    // 'n' was an unused simulation-only variable ('set but not read'), which caused W528.
    // Removing it resolves the violation and does not alter any observable functional behavior.

endmodule
