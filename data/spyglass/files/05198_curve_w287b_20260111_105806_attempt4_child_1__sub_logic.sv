module sub_logic (
    input wire in_a,
    input wire in_b,
    output wire out_and,
    output wire out_or
);
    assign out_and = in_a & in_b;
    assign out_or = in_a | in_b;
endmodule
