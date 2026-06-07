module curve_starc05_2_1_3_1_20260111_054323_attempt4 (
    input [3:0] in_a,
    input [3:0] in_b,
    input [3:0] in_c,
    input [3:0] in_d,
    input [3:0] in_e,
    input [3:0] in_f,
    input [3:0] in_g,
    input [3:0] in_h,
    input [3:0] in_i,
    input [3:0] in_j,

    output [31:0] out_a,
    output [31:0] out_b,
    output [31:0] out_c,
    output [31:0] out_d,
    output [31:0] out_e,
    output [31:0] out_f,
    output [31:0] out_g,
    output [31:0] out_h,
    output [31:0] out_i,
    output [31:0] out_j
);

    // Function that expects a 32-bit input
    function [31:0] widen_and_add;
        input [31:0] large_input; // 32-bit function input
        begin
            widen_and_add = large_input + 1;
        end
    endfunction

    // Call the function 10 times, passing 4-bit inputs to a 32-bit argument.
    // Each call will trigger a STARC05-2.1.3.1 violation, for a total of 10 occurrences.
    // The argument 'in_x' (4 bits) has a bit-width mismatch with the function input 'large_input' (32 bits).
    assign out_a = widen_and_add(in_a);
    assign out_b = widen_and_add(in_b);
    assign out_c = widen_and_add(in_c);
    assign out_d = widen_and_add(in_d);
    assign out_e = widen_and_add(in_e);
    assign out_f = widen_and_add(in_f);
    assign out_g = widen_and_add(in_g);
    assign out_h = widen_and_add(in_h);
    assign out_i = widen_and_add(in_i);
    assign out_j = widen_and_add(in_j);

endmodule
