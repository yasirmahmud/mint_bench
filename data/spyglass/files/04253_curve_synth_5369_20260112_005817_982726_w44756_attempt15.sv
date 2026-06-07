module curve_synth_5369_20260112_005817_982726_w44756_attempt15 (
    input wire [8:0] input_val, // Can represent values up to 511, ensuring recursion depth > 100
    output reg [16:0] sum_out   // Sufficiently wide for sum up to input_val=511 (max sum 130816, requires 17 bits)
);

    // Function to compute a recursive sum.
    // The recursion depth can exceed 100 if input_val > 100.
    // This is intended to trigger SYNTH_5369.
    function [16:0] recursive_sum;
        input [8:0] n; // Input for the recursive function
        begin
            if (n == 0) begin
                recursive_sum = 16'd0; // Base case for sum
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                // due to the potential recursion depth exceeding 100 if 'n'
                // is greater than 100.
                recursive_sum = n + recursive_sum(n - 1);
            end
        end
    endfunction

    always @(*) begin
        // Assign the result of the recursive function to the output.
        // If input_val is > 100, the recursion depth will exceed the limit.
        sum_out = recursive_sum(input_val);
    end

endmodule
