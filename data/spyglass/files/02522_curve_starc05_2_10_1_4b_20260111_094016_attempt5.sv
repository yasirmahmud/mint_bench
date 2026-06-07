module curve_starc05_2_10_1_4b_20260111_094016_attempt5 (
  input  wire [3:0] data_in,
  output reg         out_flag
);

  always @(*) begin
    out_flag = 1'b0; // Default assignment to avoid latches
    // STARC05-2.10.1.4b: Signal compared with value containing x or z
    // The comparison `data_in === 4'b10xz` directly triggers the rule.
    // The literal `4'b10xz` contains both 'x' and 'z' values.
    if (data_in === 4'b10xz) begin
      out_flag = 1'b1;
    end
  end

endmodule
