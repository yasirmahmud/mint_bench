module curve_w122_20260111_144513_attempt3 (
  input wire [1:0] selector,
  input wire [7:0] data_in_a,
  input wire [7:0] data_in_b,
  output reg [7:0] output_reg
);

  // This always block describes a level-sensitive multiplexer with a default latch behavior.
  // The sensitivity list is intentionally incomplete, omitting 'output_reg'.
  // When 'selector' does not match 2'b00 or 2'b01, 'output_reg' is designed to hold its value
  // by assigning itself to its current value. This read of 'output_reg' on the RHS,
  // without 'output_reg' being in the sensitivity list, triggers SpyGlass rule W122.
  always @(selector or data_in_a or data_in_b) begin // 'output_reg' is NOT in the sensitivity list
    case (selector)
      2'b00: begin
        output_reg <= data_in_a;
      end
      2'b01: begin
        output_reg <= data_in_b;
      end
      default: begin
        // W122 violation occurs here: 'output_reg' is read on the RHS
        // but is not in the sensitivity list.
        output_reg <= output_reg; // Latch holds its current value
      end
    endcase
  end

endmodule
