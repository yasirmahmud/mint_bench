module star_c02_2_10_1_3_ex1(input in_a, output reg out_q);
  always @(*) begin
    // The original comparison 'in_a == 1'bx' in an 'if' statement
    // evaluates to false in synthesis and typically to 'x' (which acts as false)
    // in simulation when 'in_a' or the comparison value contains 'x'.
    // Therefore, the 'else' branch 'out_q = 1'b0;' was always taken.
    // To preserve this functional behavior and resolve the violations,
    // 'out_q' is explicitly set to 1'b0.
    out_q = 1'b0;
  end
endmodule
