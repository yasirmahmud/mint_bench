module Binary_BCD(clk,bin,bcd,ones,tens,hundreds);
input clk;
input [8:0]bin;
output reg [15:0]bcd;
output reg [3:0]ones,tens,hundreds;

// Internal registers for combinatorial calculation
// These will hold the intermediate values computed by the combinatorial logic.
reg [15:0] bcd_comb;
reg [3:0] ones_comb, tens_comb, hundreds_comb;
integer i; // Loop counter, declared at module level as in original code

// Combinatorial logic block: This block computes the BCD conversion synchronously based on current inputs.
// All assignments within this block use blocking assignments (=), which is appropriate for combinatorial logic.
always @(*) begin
    // Initialize bcd_comb for each combinatorial evaluation, mimicking 'bcd=0;' from original code.
    bcd_comb = 0; // This is the first and only assignment to bcd_comb outside the loop.

    // The double dabble algorithm loop runs combinatorially within this block.
    for(i=0; i<9; i=i+1) begin
        // Use a temporary variable to hold the BCD value after adjustments for the current iteration.
        // This ensures that 'bcd_comb' is assigned only once per iteration of the loop,
        // resolving the W415a violations. 'bcd_adjusted_for_shift' is declared locally
        // within the loop, meaning each unrolled iteration conceptually has its own temporary variable.
        reg [15:0] bcd_adjusted_for_shift;

        // Initialize the temporary variable with the current state of bcd_comb
        // (which holds the result from the previous iteration or its initial value).
        bcd_adjusted_for_shift = bcd_comb;

        // Adjust BCD digits if they are >= 5 (add 3).
        // These adjustments are applied to the temporary variable, not directly to bcd_comb.
        if(bcd_adjusted_for_shift[3:0] >= 5)
            bcd_adjusted_for_shift[3:0] = bcd_adjusted_for_shift[3:0] + 3;
        if(bcd_adjusted_for_shift[7:4] >= 5)
            bcd_adjusted_for_shift[7:4] = bcd_adjusted_for_shift[7:4] + 3;
        if(bcd_adjusted_for_shift[11:8] >= 5)
            bcd_adjusted_for_shift[11:8] = bcd_adjusted_for_shift[11:8] + 3;
        if(bcd_adjusted_for_shift[15:12] >= 5)
            bcd_adjusted_for_shift[15:12] = bcd_adjusted_for_shift[15:12] + 3;

        // Shift the BCD register left and append the next binary bit from the input.
        // This is the *only* assignment to 'bcd_comb' within this loop iteration,
        // using the value from 'bcd_adjusted_for_shift'.
        bcd_comb = {bcd_adjusted_for_shift[14:0], bin[8-i]};
    end

    // Assign the final combinatorial results to the temporary output registers.
    ones_comb = bcd_comb[3:0];
    tens_comb = bcd_comb[7:4];
    hundreds_comb = bcd_comb[11:8];
end

// Sequential logic block: This block registers the combinatorial results at each positive clock edge.
// All assignments within this block use non-blocking assignments (<=), which is appropriate for sequential logic.
// Each output register is assigned exactly once per clock cycle, resolving W415a and STARC05 violations.
always @(posedge clk) begin
    bcd <= bcd_comb;
    ones <= ones_comb;
    tens <= tens_comb;
hundreds <= hundreds_comb;
end

endmodule
