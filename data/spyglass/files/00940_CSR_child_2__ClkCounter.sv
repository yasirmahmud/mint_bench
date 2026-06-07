module ClkCounter(
    input clk_small,
    input rst,
    output reg counter,
    output Dclk
);
    // This is a placeholder for the actual clock counter logic.
    // It generates a single-cycle 'counter' pulse periodically,
    // synchronous to clk_small. Dclk simply outputs clk_small.
    // For linting, a simple counter suffices.
    parameter COUNT_LIMIT = 10000; // Generate pulse every N clk_small cycles
    reg [13:0] count_reg;

    assign Dclk = clk_small; // Dclk is the same as clk_small for this context

    always @(posedge clk_small or posedge rst) begin
        if (rst) begin
            count_reg <= 0;
            counter <= 0;
        end else begin
            if (count_reg == COUNT_LIMIT - 1) begin
                count_reg <= 0;
                counter <= 1; // Assert pulse for one clock cycle
            end else begin
                count_reg <= count_reg + 1;
                counter <= 0; // Deassert pulse
            end
        end
    end
endmodule
