module curve_starc05_2_5_1_7_20260110_223425_attempt5 (
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

  // Violation 1 fixed: Replaced 'tri_o' with its active-high driving condition
  always @(*) begin
    data_a_o = 1'b0; // Default assignment to prevent latch
    if (ctrl_a_i) begin
      if (en_i && data_i) begin // STARC05-2.5.1.7 violation fixed
        data_a_o = 1'b1;
      end
    end
  end

  // Violation 2 fixed: Replaced 'tri_o' with its active-high driving condition
  always @(*) begin
    data_b_o = 1'b0; // Default assignment to prevent latch
    if (ctrl_b_i) begin
      if (en_i && data_i) begin // STARC05-2.5.1.7 violation fixed
        data_b_o = 1'b1;
      }
    }
  end

  // Violation 3 fixed: Replaced 'tri_o' with its active-high driving condition
  always @(*) begin
    data_c_o = 1'b0; // Default assignment to prevent latch
    if (ctrl_c_i) begin
      if (en_i && data_i) begin // STARC05-2.5.1.7 violation fixed
        data_c_o = 1'b1;
      end
    }
  end

endmodule
