module curve_synth_5369_20260110_205036_attempt4 (
    input [7:0] in_n,
    output [31:0] out_result
);

    // Function to compute factorial recursively.
    // The input 'n' is declared as [7:0], allowing values up to 255.
    // A potential recursion depth of 255 is well over the typical synthesis
    // tool's recursion limit of 100, which will trigger a SYNTH_5369 violation.
    // The return value width is 32 bits to accommodate large factorial results
    // and to explicitly handle width matching.
    function [31:0] factorial_func;
        input [7:0] n;
        begin
            if (n <= 1) begin
                factorial_func = 32'd1; // Base case: factorial(0) = 1, factorial(1) = 1
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                // due to the potential recursion depth exceeding 100.
                factorial_func = (32'd0 + n) * factorial_func(n - 1); // (32'd0 + n) ensures 'n' is widened to 32 bits
            end
        end
    endfunction

    // Assign the output based on the recursive function.
    // Driving the function with an input `in_n` (width [7:0]) allows the
    // worst-case recursion depth to be 255, which is greater than the
    // typical recursion limit of 100.
    assign out_result = factorial_func(in_n);

endmodule
