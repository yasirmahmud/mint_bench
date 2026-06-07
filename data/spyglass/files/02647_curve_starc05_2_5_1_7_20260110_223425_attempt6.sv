module curve_starc05_2_5_1_7_20260110_223425_attempt6 (
  input wire        data_i,
  input wire        en_i,
  input wire        ctrl_a_i,
  input wire        ctrl_b_i,
  input wire        ctrl_c_i,
  output wire       tri_o,
  output reg        data_a_o,
  output reg        data_b_o,
  output reg        data_c_o
);

  // Assign a tri-state value to 'tri_o'
  assign tri_o = en_i ? data_i : 1'bz;

  // All violations are contained within a single always block to be distinct from previous attempts.
  // Each 'if (tri_o)' instance below should trigger a separate STARC05-2.5.1.7 violation.
  always @(*) begin
    // Default assignments to prevent latches
    data_a_o = 1'b0;
    data_b_o = 1'b0;
    data_c_o = 1'b0;

    // Violation 1: Direct check in an if statement, guarded by ctrl_a_i
    if (ctrl_a_i) begin
      if (tri_o) begin // STARC05-2.5.1.7 violation 1
        data_a_o = 1'b1;
      end
    end

    // Violation 2: Check within a compound conditional expression, guarded by ctrl_b_i
    if (ctrl_b_i) begin
      if (data_i && tri_o) begin // STARC05-2.5.1.7 violation 2
        data_b_o = 1'b1;
      end
    end

    // Violation 3: Check in an else-if branch, guarded by ctrl_c_i
    if (ctrl_c_i) begin
      data_c_o = 1'b0; // Assigned here to differentiate from else if
    end else if (tri_o) begin // STARC05-2.5.1.7 violation 3
      data_c_o = 1'b1;
    end else begin
      data_c_o = 1'b0; // Default when neither condition is met
    end
  end

endmodule
