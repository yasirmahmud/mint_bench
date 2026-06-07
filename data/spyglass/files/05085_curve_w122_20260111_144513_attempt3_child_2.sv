module curve_w122_20260111_144513_attempt3 (
  input wire [1:0] selector,
  input wire [7:0] data_in_a,
  input wire [7:0] data_in_b,
  output reg [7:0] output_reg
);

  // This always block describes a level-sensitive multiplexer with a default latch behavior.
  // The SpyGlass W502 violations (signal 'output_reg' modified in always block) are addressed by
  // adopting a common Verilog style for implicit latch inference.
  // 'output_reg' is removed from the sensitivity list, and the explicit 'output_reg <= output_reg'
  // statement is removed from the default case. A latch is now implicitly inferred
  // for selector values not explicitly assigned within the case statement.
  always @(selector or data_in_a or data_in_b) begin // Sensitivity list updated
    case (selector)
      2'b00: begin
        output_reg <= data_in_a;
      end
      2'b01: begin
        output_reg <= data_in_b;
      end
      // For any 'selector' value not explicitly covered (e.g., 2'b10, 2'b11),
      // 'output_reg' is not assigned. In Verilog, if a 'reg' is not assigned
      // in all possible paths within a level-sensitive 'always' block,
      // a latch is implicitly inferred to hold its previous value.
      // This preserves the specified "default latch behavior".
    endcase
  end

endmodule
