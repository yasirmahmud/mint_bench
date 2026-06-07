module my_logic_block (
    input wire in_a,
    input wire in_b,
    output wire sum_out,
    output wire carry_out
);
    assign sum_out = in_a ^ in_b;
    assign carry_out = in_a & in_b;
endmodule
