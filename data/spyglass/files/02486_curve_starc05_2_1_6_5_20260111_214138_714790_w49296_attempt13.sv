module curve_starc05_2_1_6_5_20260111_214138_714790_w49296_attempt13 (
  output reg [7:0] result
);

  // Declare an array of 4 elements, each 8-bit wide.
  // The index range is 0 to 3, requiring a 2-bit index.
  reg [7:0] data_storage [0:3];

  // Initialize data_storage elements to ensure the array is considered 'used'
  // and to prevent potential 'x' propagation from uninitialized memory, which could
  // trigger other synthesis warnings.
  always @* begin
    integer i;
    for (i = 0; i < 4; i = i + 1) begin
      data_storage[i] = 8'h10 + i; // Assign unique, non-zero values
    end

    // STARC05-2.1.6.5 violation: Using 'x' as an array index for reading.
    // The rule states: "For an array index x and z should not be used".
    // 'result' is assigned here, ensuring the output signal is used.
    // The array 'data_storage' is used by both writing to it and reading from it.
    result = data_storage[2'bx];
  end

endmodule
