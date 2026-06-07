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
    reg [19:0] next_counter; // Combinational next value for counter
    reg        next_tick;    // Combinational next value for tick

    // Combinational logic for next state and next output
    always @(*) begin
        next_counter = counter + 1;
        next_tick = 1'b0; // Default no tick

        if (counter == COUNT_MAX) begin
            next_counter = 20'b0;
            next_tick = 1'b1; // Generate a single-cycle tick pulse
        end
    end

    // Sequential logic for state and output updates
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 20'b0;
            tick <= 1'b0;
        end else begin
            counter <= next_counter;
            tick <= next_tick;
        end
    end

endmodule
