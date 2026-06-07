module curve_synth_12605_20260111_013718_attempt14 (
  input [1:0] sel_in,
  output reg out_0,
  output reg out_1,
  output reg out_2,
  output reg out_3,
  output reg out_4
);

  // Occurrence 1: Incomplete case statement for out_0
  always @* begin
    // Missing 2'b10, 2'b11, no default
    case (sel_in)
      2'b00: out_0 = 1'b1;
      2'b01: out_0 = 1'b0;
    endcase
  end

  // Occurrence 2: Incomplete case statement for out_1
  always @* begin
    // Missing 2'b10, 2'b11, no default
    case (sel_in)
      2'b00: out_1 = 1'b0;
      2'b01: out_1 = 1'b1;
    endcase
  end

  // Occurrence 3: Incomplete case statement for out_2 (even more cases missing)
  always @* begin
    // Missing 2'b01, 2'b10, 2'b11, no default
    case (sel_in)
      2'b00: out_2 = 1'b1;
    endcase
  end

  // Occurrence 4: Incomplete case statement for out_3 (different missing cases)
  always @* begin
    // Missing 2'b00, 2'b01, no default
    case (sel_in)
      2'b10: out_3 = 1'b0;
      2'b11: out_3 = 1'b1;
    endcase
  end

  // Occurrence 5: Incomplete case statement for out_4
  always @* begin
    // Missing 2'b10, 2'b11, no default
    case (sel_in)
      2'b00: out_4 = 1'b0;
      2'b01: out_4 = 1'b1;
    endcase
  end

endmodule
