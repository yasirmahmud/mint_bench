module day12_child_1 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg match_o
);

  // As per design description, this module implements a 12-bit shift register.
  parameter SHIFT_REG_WIDTH = 12;
  localparam MATCH_PATTERN = 12'b1110_1101_1011; // The target pattern to match

  reg [SHIFT_REG_WIDTH-1:0] shift_reg; // The 12-bit shift register

  // Synchronous shift register logic with active-low reset
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Reset the shift register to all zeros
      shift_reg <= '0;
    end else begin
      // Shift in the new data_in bit into the LSB (bit 0)
      // This is a left shift, where data_in enters from the right (LSB)
      // and existing bits shift towards the left (MSB). The MSB is discarded.
      shift_reg <= {shift_reg[SHIFT_REG_WIDTH-2:0], data_in};
    end
  end

  // Combinational logic to assert output when the register matches the pattern
  always @(*) begin
    if (shift_reg == MATCH_PATTERN) begin
      match_o = 1'b1; // Pattern matched
    end else begin
      match_o = 1'b0; // No match
    end
  end

endmodule
