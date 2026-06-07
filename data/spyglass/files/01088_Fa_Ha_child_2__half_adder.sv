module half_adder(input in1, in2,
    output sum_out, carry_out);

    assign sum_out = in1 ^ in2;
    assign carry_out = in1 & in2;

endmodule
