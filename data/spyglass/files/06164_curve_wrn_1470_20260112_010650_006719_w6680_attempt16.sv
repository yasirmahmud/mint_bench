module curve_wrn_1470_20260112_010650_006719_w6680_attempt16 (
    input in_a,
    input in_b,
    input in_c,
    input in_d,
    input in_e,
    input in_f,
    output reg [3:0] out_vec_A,
    output reg [4:0] out_vec_B,
    output reg [2:0] out_vec_C
);

  // WRN_1470 #1: This always block uses a SystemVerilog assignment pattern
  // with explicit integer keys (0, 3) and a 'default' key, which is not supported in Verilog-2001.
  always @(*) begin
    out_vec_A = '{0: in_a, 3: in_b, default: 1'b0};
  end

  // WRN_1470 #2: Another instance of the unsupported array pattern key construct.
  // This assignment uses a different set of explicit keys (1, 4) and a default value
  // derived from an input signal, targeting a 5-bit vector.
  always @(*) begin
    out_vec_B = '{1: in_c, 4: in_d, default: in_e};
  end

  // WRN_1470 #3: A third distinct instance of the array pattern key construct.
  // This assignment uses a single explicit key (2) and a constant '1' for the default value,
  // targeting a 3-bit vector, to demonstrate multiple occurrences of the violation.
  always @(*) begin
    out_vec_C = '{2: in_f, default: 1'b1};
  end

endmodule
