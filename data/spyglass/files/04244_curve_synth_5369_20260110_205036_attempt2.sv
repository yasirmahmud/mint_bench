module curve_synth_5369_20260110_205036_attempt2 (
    input [7:0] in_a,
    input [7:0] in_b,
    output [31:0] out_sum_seq,
    output [31:0] out_prod_seq
);

    // Function 1: Computes a recursive sum sequence
    // The input 'n' is [7:0], allowing values up to 255.
    // A recursion depth of 255 is well over the typical limit of 100,
    // leading to a SYNTH_5369 violation.
    function [31:0] recursive_sum;
        input [7:0] n;
        begin
            if (n <= 1) begin
                recursive_sum = n;
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                recursive_sum = recursive_sum(n - 1) + n;
            end
        end
    endfunction

    // Function 2: Computes a recursive product sequence (like factorial)
    // Similar to Function 1, 'm' is [7:0], potentially causing recursion
    // depth up to 255, exceeding the limit of 100.
    // This ensures a second SYNTH_5369 violation.
    function [31:0] recursive_product;
        input [7:0] m;
        begin
            if (m <= 1) begin
                recursive_product = 1;
            end else begin
                // This recursive call line is expected to trigger SYNTH_5369
                recursive_product = recursive_product(m - 1) * m;
            end
        end
    endfunction

    // Instantiate the functions, providing inputs that can cause deep recursion.
    // Each call implicitly refers to the recursive logic within its respective function.
    assign out_sum_seq = recursive_sum(in_a);
    assign out_prod_seq = recursive_product(in_b);

endmodule
