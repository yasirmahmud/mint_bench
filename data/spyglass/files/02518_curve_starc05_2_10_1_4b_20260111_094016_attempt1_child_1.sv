module curve_starc05_2_10_1_4b_20260111_094016_attempt1 (
  input  wire [1:0]  data_in,
  output reg         flag_out
);

  always @(*) begin
    // The original intent was to set flag_out = 1'b1 if data_in[0] is 'x'.
    // However, comparison with 'x' (1'bx) is not synthesizable and violates STARC05-2.10.1.4a/4b.
    // In synthesizable hardware, an input signal like data_in[0] is always '0' or '1'.
    // Therefore, the condition (data_in[0] === 1'bx) would never be true in hardware.
    // To preserve the functional behavior within synthesizable constraints (where 'x' cannot be detected),
    // flag_out will always be 1'b0, as the 'x' condition for setting it to 1'b1 can never be met.
    flag_out = 1'b0;
  end

endmodule
