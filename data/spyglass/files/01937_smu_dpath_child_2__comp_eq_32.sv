// Behavioral model for 32-bit equality comparator
module comp_eq_32 (output eq,
                   input [31:0] in1, in2);
    assign eq = (in1 == in2);
endmodule
