module curve_w240_20260111_160401_066985_w30032_attempt5 (
    input  operand_a,
    input  operand_b,
    input  rst, // This input is declared but not read, triggering W240.
    output sum_out
);

// A simple XOR gate using other inputs, ensuring they are used.
assign sum_out = operand_a ^ operand_b;

endmodule
