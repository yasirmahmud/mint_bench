module shiftReg( input clk,
                 input reset,
                 input wake,
                 input dataIN,
                 input outEN,
                 output reg error,
                 output reg [15:0] CRC_out);
    reg [0:15] Remainder;

    // Removed 'r_CRC' as it was set but never read (W528 violation)
    // Removed 'initial' block, replaced with synchronous reset (SYNTH_5143 violation)

    always @(posedge clk) begin
        // Output register logic (error and CRC_out)
        // This logic updates every clock cycle, independent of 'wake' and 'reset',
        // maintaining the original design behavior.
        if (outEN == 1'b1) begin
            CRC_out <= Remainder; // Transfer current Remainder to output
            error <= 1'b0;      // Clear error, indicating valid data
        end else begin
            error <= 1'b1;      // Set error if output not enabled
        end

        // CRC register (Remainder) update logic
        // Implemented synchronous reset using the 'reset' input (W240 violation fixed).
        // This is the highest priority reset.
        if (reset == 1'b1) begin
            Remainder <= 16'd0;
        end
        // Next priority: idle state (wake = 0). As per design description, it resets when idle.
        else if (wake == 1'b0) begin // System is in idle state
            Remainder <= 16'd0; // Reset Remainder
        end
        // If not reset and not idle (wake = 1), perform CRC computation.
        else begin // wake == 1'b1, register will start operating
            // Calculate feedback bit once to simplify logic and maintain original behavior.
            // Given 'reg [0:15] Remainder;' and the shift pattern, Remainder[0] is interpreted as the MSB.
            bit fb_bit = dataIN ^ Remainder[0];

            // CRC computation: shifting and XOR'ing. All assignments use the value of Remainder
            // from *before* this clock edge due to non-blocking assignments.
            Remainder[15] <= fb_bit;
            Remainder[14] <= Remainder[15];
            Remainder[13] <= Remainder[14];
            Remainder[12] <= Remainder[13];
            Remainder[11] <= Remainder[12];
            Remainder[10] <= Remainder[11] ^ fb_bit; // Tap at Remainder[11]
            Remainder[9]  <= Remainder[10];
            Remainder[8]  <= Remainder[9];
            Remainder[7]  <= Remainder[8];
            Remainder[6]  <= Remainder[7];
            Remainder[5]  <= Remainder[6];
            Remainder[4]  <= Remainder[5];
            Remainder[3]  <= Remainder[4] ^ fb_bit; // Tap at Remainder[4]
            Remainder[2]  <= Remainder[3];
            Remainder[1]  <= Remainder[2];
            Remainder[0]  <= Remainder[1];
        end
    end
endmodule
