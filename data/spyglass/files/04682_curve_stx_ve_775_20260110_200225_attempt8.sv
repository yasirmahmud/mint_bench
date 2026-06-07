module curve_stx_ve_775_20260110_200225_attempt8 (
  output reg [3:0] data_out_a,
  output reg [3:0] data_out_b
);

  // STX_VE_775: Initial statement not allowed in this scope.
  // As per Verilog-2001 (IEEE Std 1364-2001, Section 12.3),
  // 'initial' statements are not allowed directly within a 'generate for' construct.
  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin : gen_loop_a
      initial begin // Expected STX_VE_775 (1 of 2 occurrences)
        data_out_a[i] = 1'b0;
      end
    end
  endgenerate

  // Second occurrence for total count of 2.
  genvar j;
  generate
    for (j = 0; j < 4; j = j + 1) begin : gen_loop_b
      initial begin // Expected STX_VE_775 (2 of 2 occurrences)
        data_out_b[j] = 1'b1;
      end
    end
  endgenerate

endmodule
