module curve_synth_12605_20260111_013718_attempt11 (
  input [1:0] sel_in,
  output reg out_0,
  output reg out_1,
  output reg out_2,
  output reg out_3,
  output reg out_4
);

  // Instance 1: Incomplete case statement for out_0
  // Conditions 2'b11 are not explicitly covered.
  always @* begin
    case (sel_in)
      2'b00: out_0 = 1'b1;
      2'b01: out_0 = 1'b0;
      2'b10: out_0 = 1'b1;
    endcase
  end

  // Instance 2: Incomplete case statement for out_1
  // Condition 2'b00 is not explicitly covered.
  always @* begin
    case (sel_in)
      2'b01: out_1 = 1'b1;
      2'b10: out_1 = 1'b0;
      2'b11: out_1 = 1'b1;
    endcase
  end

  // Instance 3: Incomplete case statement for out_2
  // Conditions 2'b01, 2'b10, 2'b11 are not explicitly covered.
  always @* begin
    case (sel_in)
      2'b00: out_2 = 1'b1;
    endcase
  end

  // Instance 4: Incomplete case statement for out_3
  // Condition 2'b10 is not explicitly covered.
  always @* begin
    case (sel_in)
      2'b00: out_3 = 1'b1;
      2'b01: out_3 = 1'b0;
      2'b11: out_3 = 1'b1;
    endcase
  end

  // Instance 5: Incomplete case statement for out_4
  // Conditions 2'b00 and 2'b01 are not explicitly covered.
  always @* begin
    case (sel_in)
      2'b10: out_4 = 1'b1;
      2'b11: out_4 = 1'b0;
    endcase
  end

endmodule
