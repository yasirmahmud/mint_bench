module casex_example_04(
  input [0:0] single_bit_in,
  output reg single_bit_out
);
  always @* begin
    // Original 'casex' with '1'bx' as a case item matches any value of 'single_bit_in'
    // (0, 1, x, or z) because 'x' in 'casex' case items acts as a don't-care.
    // Therefore, the first case item '1'bx' always matches, making 'single_bit_out' always '1'b1'.
    // The second case '1'b0' is never reached, leading to the reported SpyGlass violations.
    // To preserve this observed functional behavior and resolve the violations,
    // 'single_bit_out' is explicitly assigned '1'b1'.
    single_bit_out = 1'b1;
  end
endmodule
