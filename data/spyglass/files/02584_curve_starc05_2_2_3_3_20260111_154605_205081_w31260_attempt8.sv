module curve_starc05_2_2_3_3_20260111_154605_205081_w31260_attempt8 (
    input wire clk,
    input wire reset,
    input wire data_in,
    output reg buffer_full
);

// This module targets STARC05-2.2.3.3: Flipflop 'buffer_full' is assigned over the same signal
// in an always construct for sequential circuits.

always @(posedge clk or posedge reset) begin
    if (reset) begin
        buffer_full <= 1'b0;
    end else begin
        // The first assignment to 'buffer_full'
        buffer_full <= data_in;

        // STARC05-2.2.3.3 violation: 'buffer_full' is assigned again within the same always block.
        // This second assignment "overwrites" the effect of the first one for the same clock cycle,
        // causing a multiple assignment scenario to the same flip-flop, which SpyGlass interprets
        // as being "assigned over the same signal". This pattern is similar to context example 2
        // where a bit of an array was assigned twice.
        buffer_full <= ~data_in;
    end
end

endmodule
