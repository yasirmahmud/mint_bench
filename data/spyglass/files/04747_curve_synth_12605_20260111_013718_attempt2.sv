module curve_synth_12605_20260111_013718_attempt2 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    // 'out' is not assigned a default value here.
    // The case statement below does not cover all possible 2'b values for 'sel'.
    // Specifically, when sel is 2'b10 or 2'b11, 'out' will not be explicitly assigned.
    // This incompleteness within a combinational always block will infer a latch
    // for 'out' for the uncovered conditions, which is often detected by
    // SpyGlass as an incomplete priority case statement.
    case (sel) // This is a Verilog-2001 case statement forming a priority structure.
      2'b00: begin
        out = 1'b0;
      end
      2'b01: begin
        out = 1'b1;
      end
      // Missing case items for 2'b10 and 2'b11.
      // This lack of complete condition coverage is expected to trigger SYNTH_12605.
    endcase
  end

endmodule
