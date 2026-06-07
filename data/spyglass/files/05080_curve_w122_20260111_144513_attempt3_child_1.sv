module curve_w122_20260111_144513_attempt3 (
  input wire [1:0] selector,
  input wire [7:0] data_in_a,
  input wire [7:0] data_in_b,
  output reg [7:0] output_reg
);

  // This always block describes a level-sensitive multiplexer with a default latch behavior.
  // To resolve W122, 'output_reg' must be included in the sensitivity list because it is read on the RHS.
  always @(selector or data_in_a or data_in_b or output_reg) begin // 'output_reg' is now in the sensitivity list
    case (selector)
      2'b00: begin
        output_reg <= data_in_a;
      end
      2'b01: begin
        output_reg <= data_in_b;
      end
      default: begin
        // The W122 violation is resolved by adding 'output_reg' to the sensitivity list.
        output_reg <= output_reg; // Latch holds its current value
      end
    endcase
  end

endmodule
