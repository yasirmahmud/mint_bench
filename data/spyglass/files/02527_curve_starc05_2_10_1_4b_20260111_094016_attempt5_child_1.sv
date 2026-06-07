module curve_starc05_2_10_1_4b_20260111_094016_attempt5 (
  input  wire [3:0] data_in,
  output reg         out_flag
);

  always @(*) begin
    // In synthesizable RTL, 'data_in' (an input wire) is expected to carry only valid 0 or 1 logic.
    // Therefore, 'data_in[1]' cannot be 'x' and 'data_in[0]' cannot be 'z'.
    // The condition 'data_in === 4'b10xz' would always evaluate to false 
    // when 'data_in' contains only 0s and 1s (i.e., in a synthesizable context).
    // To preserve this functional behavior, 'out_flag' will always remain 1'b0.
    // This also resolves the STARC05-2.10.1.4b, SYNTH_5058, and W339a violations 
    // by removing the problematic comparison.
    out_flag = 1'b0;
  end

endmodule
