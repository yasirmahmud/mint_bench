module curve_synth_5369_20260110_205036_attempt3 (
    input [7:0] in_a,
    input [7:0] in_b,
    output [31:0] out_sum_seq,
    output [31:0] out_fib_seq
);

    // Function 1: Computes the sum of numbers from 1 to n recursively.
    // The input 'n' is [7:0], allowing values up to 255. A recursion depth
    // of 255 is well over the typical limit of 100, leading to a SYNTH_5369 violation.
    // The return value `32'd0 + n` ensures explicit width matching to avoid W416.
    function [31:0] sum_up_to_n;
        input [7:0] n;
        begin
            if (n <= 1) begin
                sum_up_to_n = 32'd0 + n; // Explicitly widen n to 32 bits to avoid W416
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                sum_up_to_n = n + sum_up_to_n(n - 1);
            end
        end
    endfunction

    // Function 2: Computes the Fibonacci sequence recursively.
    // Similar to Function 1, 'm' is [7:0], potentially causing recursion
    // depth up to 255, exceeding the limit of 100. This function involves
    // two recursive calls, making it very prone to deep recursion, ensuring
    // a second SYNTH_5369 violation. The explicit width matching avoids W416.
    function [31:0] fibonacci_seq;
        input [7:0] m;
        begin
            if (m <= 1) begin
                fibonacci_seq = 32'd0 + m; // Explicitly widen m to 32 bits to avoid W416
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                fibonacci_seq = fibonacci_seq(m - 1) + fibonacci_seq(m - 2);
            end
        end
    endfunction

    // Instantiate the functions, providing inputs that can cause deep recursion.
    // The synthesis tool will analyze the worst-case recursion based on input width.
    assign out_sum_seq = sum_up_to_n(in_a);
    assign out_fib_seq = fibonacci_seq(in_b);

endmodule
