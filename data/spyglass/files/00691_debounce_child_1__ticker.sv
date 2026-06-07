module ticker (
    input clk,
    input reset,
    output reg tick
);

    // Parameter for a 10ms tick, assuming a 100MHz clock.
    // Calculation: 100,000,000 Hz * 0.01s = 1,000,000 clock cycles.
    // A 20-bit counter is needed for 1,000,000 cycles (2^19 approx 500k, 2^20 approx 1M).
    parameter COUNT_MAX = 20'd999_999;

    reg [19:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 20'b0;
            tick <= 1'b0;
        end else begin
            if (counter == COUNT_MAX) begin
                counter <= 20'b0;
                tick <= 1'b1; // Generate a single-cycle tick pulse
            end else begin
                counter <= counter + 1;
                tick <= 1'b0; // No tick
            end
        end
    end

endmodule
