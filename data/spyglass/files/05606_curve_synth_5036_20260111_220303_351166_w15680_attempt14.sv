module curve_synth_5036_20260111_220303_351166_w15680_attempt14 (
    input wire [7:0] in_a,
    input wire [7:0] in_b,
    input wire [7:0] in_c,
    input wire [7:0] in_d,
    output reg [7:0] out_mul_res,
    output reg [7:0] out_div_res
);

    // Rule: SYNTH_5036 - NonBlocking assignment in subprogram will be treated as blocking for synthesis
    // This function demonstrates the target violation.
    function [7:0] calculate_product (input [7:0] operand1, input [7:0] operand2);
        calculate_product <= operand1 * operand2; // Violation 1 for SYNTH_5036
    endfunction

    // This second function ensures exactly two occurrences of the SYNTH_5036 rule.
    function [7:0] calculate_quotient (input [7:0] numerator, input [7:0] denominator);
        // Non-blocking assignment inside a function will be treated as blocking.
        calculate_quotient <= (denominator == 8'd0) ? 8'd0 : (numerator / denominator); // Violation 2 for SYNTH_5036
    endfunction

    // Instantiate the functions to use their return values and avoid 'unused function' warnings.
    always @* begin
        out_mul_res = calculate_product(in_a, in_b);
        out_div_res = calculate_quotient(in_c, in_d);
    end

endmodule
