module curve_starc05_2_5_1_7_20260110_223425_attempt3 (
  input wire ctrl_a,
  input wire data_a,
  input wire ctrl_b,
  input wire data_b,
  input wire ctrl_c,
  input wire data_c,
  output wire tri_out_a,
  output wire tri_out_b,
  output wire tri_out_c
);

  // Assign tri-state values to the outputs
  assign tri_out_a = ctrl_a ? data_a : 1'bz;
  assign tri_out_b = ctrl_b ? data_b : 1'bz;
  assign tri_out_c = ctrl_c ? data_c : 1'bz;

  // Use the tri-state outputs in conditional expressions.
  // Each 'if' statement below will trigger a STARC05-2.5.1.7 violation.
  // The 'if' blocks are intentionally empty as their content is not relevant
  // for this specific violation and helps avoid other rule triggers.
  always @* begin
    if (tri_out_a) begin // STARC05-2.5.1.7 violation 1
      // No assignments needed here
    end

    if (tri_out_b) begin // STARC05-2.5.1.7 violation 2
      // No assignments needed here
    }

    if (tri_out_c) begin // STARC05-2.5.1.7 violation 3
      // No assignments needed here
    end
  end

endmodule
