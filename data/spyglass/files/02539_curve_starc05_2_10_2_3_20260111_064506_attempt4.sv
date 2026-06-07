module curve_starc05_2_10_2_3_20260111_064506_attempt4 (
  input [2:0] data_vector,
  output reg  result_out
);

  // STARC05-2.10.2.3: Logical negation used on a vector '(!data_vector)'
  // This example attempts to trigger ONLY the target rule by using the logical negation
  // of a multi-bit vector as the selection expression for a 'case' statement.
  // This context strongly reinforces the intent of a boolean evaluation (0 or 1),
  // making a bit-wise NOT (~) operator semantically nonsensical in this specific position.
  // The expectation is that this distinct usage within a case statement's selection
  // will avoid other related rules like STARC05-2.1.4.5 (suggesting bit-wise operator),
  // which often trigger alongside STARC05-2.10.2.3 in simpler assignment or if conditions.

  always @(*) begin
    case (!data_vector) // Violation point: Logical negation on a multi-bit vector
      1'b1: begin // data_vector is all zeros
        result_out = 1'b1;
      end
      1'b0: begin // data_vector is non-zero
        result_out = 1'b0;
      end
      default: begin
        // This default case technically handles x/z, but !data_vector will resolve to 0 or 1 for well-defined inputs.
        result_out = 1'bx;
      end
    endcase
  end

endmodule
