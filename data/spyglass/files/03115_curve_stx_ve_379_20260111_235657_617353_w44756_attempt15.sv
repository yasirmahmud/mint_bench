module curve_stx_ve_379_20260111_235657_617353_w44756_attempt15 (
    output wire [7:0] output_data
);

  // Declares an array named 'buffer_values' with 5 elements, indices 0 to 4.
  reg [7:0] buffer_values [4:0];

  // STX_VE_379 violation: Incomplete array literal
  // The array literal explicitly assigns values for indices 0, 1, 3, and 4,
  // but index 2 is not assigned. This makes the literal incomplete according to SpyGlass.
  initial begin
    buffer_values = '{0: 8'hAA, 1: 8'hBB, 3: 8'hDD, 4: 8'hEE}; // Triggers STX_VE_379
  end

  // Prevent unused signal violations for the array and output by driving the output.
  assign output_data = buffer_values[0];

endmodule
