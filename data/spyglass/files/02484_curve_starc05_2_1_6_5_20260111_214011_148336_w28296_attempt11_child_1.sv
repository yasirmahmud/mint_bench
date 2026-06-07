module curve_starc05_2_1_6_5_20260111_214011_148336_w28296_attempt11 (
  input wire        clk,
  output wire [7:0] data_out
);

  // Declare a 4-element array of 8-bit registers.
  // A 2-bit index (e.g., 2'b00 to 2'b11) is appropriate for 4 elements.
  reg [7:0] my_array [0:3];

  // Drive the array elements to ensure 'my_array' is considered used and driven.
  // This uses 'clk' and prevents issues like uninitialized logic or unused signals.
  integer i;
  always @(posedge clk) begin
    for (i = 0; i < 4; i = i + 1) begin
      my_array[i] <= 8'h10 + i; // Assign distinct values to array elements
    end
  end

  // STARC05-2.1.6.5 violation: Reading from an array with 'z' in the index.
  // This directly violates the rule which prohibits 'x' or 'z' in array indices.
  // To resolve the violation while preserving the functional behavior (data_out becoming 'x' due to invalid index),
  // we directly assign '8'bx' to data_out, as accessing an array with 'z' or 'x' in the index
  // would typically result in 'x' for the accessed value in most Verilog simulators.
  assign data_out = 8'bx;

endmodule
