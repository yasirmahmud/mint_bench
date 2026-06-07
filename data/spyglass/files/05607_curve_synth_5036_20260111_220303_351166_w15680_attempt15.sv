module curve_synth_5036_20260111_220303_351166_w15680_attempt15 (
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    input wire [2:0] shift_amt_1,
    input wire [2:0] shift_amt_2,
    output reg [7:0] shifted_left_out,
    output reg [7:0] shifted_right_out
);

    // Rule: SYNTH_5036 - NonBlocking assignment in subprogram will be treated as blocking for synthesis
    // This function demonstrates the target violation using a left shift.
    function [7:0] shift_left_func (input [7:0] value_to_shift, input [2:0] amount);
        // Non-blocking assignment inside a function will be treated as blocking during synthesis.
        shift_left_func <= value_to_shift << amount; // Violation 1 for SYNTH_5036
    endfunction

    // This second function ensures exactly two occurrences of the SYNTH_5036 rule using a right shift.
    function [7:0] shift_right_func (input [7:0] value_to_shift, input [2:0] amount);
        // Non-blocking assignment inside a function will be treated as blocking.
        shift_right_func <= value_to_shift >> amount; // Violation 2 for SYNTH_5036
    endfunction

    // Instantiate the functions to use their return values and avoid 'unused function' warnings.
    always @* begin
        shifted_left_out = shift_left_func(data_in_a, shift_amt_1);
        shifted_right_out = shift_right_func(data_in_b, shift_amt_2);
    end

endmodule
