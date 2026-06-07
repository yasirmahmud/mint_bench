module curve_synth_5369_20260112_005817_982726_w44756_attempt15 (
    input wire [8:0] input_val, // Can represent values up to 511, ensuring recursion depth > 100
    output reg [16:0] sum_out   // Sufficiently wide for sum up to input_val=511 (max sum 130816, requires 17 bits)
);

    // The original recursive function 'recursive_sum' was causing SYNTH_5369 violation
    // due to potential recursion depth exceeding the synthesis tool's limit (100).
    // To resolve this, the recursive function has been replaced with a direct mathematical
    // calculation for the sum of integers from 0 to N. The formula is N * (N + 1) / 2.
    // This change preserves the functional behavior of the design.

    always @(*) begin
        // Declare intermediate variables with sufficient width for calculations to prevent overflow.
        // input_val is [8:0], with a maximum value of 511.

        // Calculate (input_val + 1). Max value is 511 + 1 = 512, which requires 10 bits.
        reg [9:0] val_plus_1;
        val_plus_1 = input_val + 1;

        // Calculate the product: input_val * val_plus_1.
        // Max product is 511 * 512 = 261632.
        // This requires 18 bits (2^17 = 131072, 2^18 = 262144). We use [18:0] (19 bits) for safety.
        reg [18:0] intermediate_product;
        intermediate_product = input_val * val_plus_1;

        // The final sum_out is [16:0], with a maximum value of 130816.
        // Perform the division by 2. The result fits into sum_out's width.
        sum_out = intermediate_product / 2;
    end

endmodule
