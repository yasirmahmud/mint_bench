module curve_synth_5369_20260110_205036_attempt1 (
    input [7:0] in_n,
    output [31:0] out_result
);

    // Define a recursive function for factorial calculation
    // The function's structure allows for a recursion depth greater than 100
    function [31:0] factorial_calc;
        input [7:0] n; // Input for the function
        begin
            if (n <= 1) begin
                factorial_calc = 1; // Base case: recursion terminates
            end else begin
                // Recursive call: This line is expected to trigger SYNTH_5369
                // as the maximum possible value of 'n' (255) implies a recursion depth > 100.
                factorial_calc = n * factorial_calc(n - 1);
            end
        end
    endfunction

    // Assign the result of the function call to the output
    // 'in_n' is a [7:0] input, which can represent values up to 255.
    // Calling 'factorial_calc' with 'in_n' thus implies a potential recursion depth
    // (up to 255) that is greater than the specified limit of 100.
    assign out_result = factorial_calc(in_n);

endmodule
