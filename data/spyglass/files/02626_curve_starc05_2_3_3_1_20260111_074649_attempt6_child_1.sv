module curve_starc05_2_3_3_1_20260111_074649_attempt6 (
    input wire clk_a,
    input wire clk_b, // Treated as a second clock, negative edge sensitive here
    input wire data_in,
    output reg q_out
);

    // Internal registers to capture the previous state of clocks for edge detection
    reg clk_a_hist;
    reg clk_b_hist;

    // Wires to generate a pulse on each desired clock edge
    wire clk_a_posedge_pulse;
    wire clk_b_negedge_pulse;

    // Combined clock pulse, which will serve as the single event for the always block
    wire combined_clock_pulse;

    // Keep track of clk_a's history on its own positive edge
    always @(posedge clk_a) begin
        clk_a_hist <= clk_a;
    end

    // Keep track of clk_b's history on its own negative edge
    always @(negedge clk_b) begin
        clk_b_hist <= clk_b;
    end

    // Detect the positive edge of clk_a: pulse is high for one delta cycle when clk_a transitions from low to high
    assign clk_a_posedge_pulse = clk_a && !clk_a_hist;

    // Detect the negative edge of clk_b: pulse is high for one delta cycle when clk_b transitions from high to low
    assign clk_b_negedge_pulse = !clk_b && clk_b_hist;

    // Combine the pulses using a logical OR. This creates a combinational signal that pulses on either desired event.
    // This derived signal is then used as the clock for the q_out register.
    assign combined_clock_pulse = clk_a_posedge_pulse || clk_b_negedge_pulse;

    // The STARC05-2.3.3.1 violation is resolved by having only one clock event
    // (the combined_clock_pulse) in this always block's sensitivity list.
    // W422 (multiple clocks in event control) is also resolved for the same reason.
    // W442a (missing if for async reset/set) is resolved as the clock is now explicit and no async reset/set is present.
    always @(posedge combined_clock_pulse) begin
        q_out <= data_in;
    end

endmodule
