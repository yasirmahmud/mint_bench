module curve_starc05_2_1_6_5_20260111_214138_714790_w49296_attempt12 (
  output wire [7:0] result
);

  // Declare an array of 8 elements, each 8-bit wide.
  // The index range is 0 to 7, requiring a 3-bit index.
  reg [7:0] data_storage [0:7];

  // Initialize data_storage elements in a combinatorial block.
  // This ensures the array is considered 'used' and avoids potential 'x' propagation
  // from uninitialized registers, which could trigger other warnings.
  always @* begin
    integer i;
    for (i = 0; i < 8; i = i + 1) begin
      data_storage[i] = 8'h00 + i; // Assign unique values
    end
  end

  // STARC05-2.1.6.5 violation: Using 'z' as an array index for reading.
  // The rule states: "For an array index x and z should not be used".
  // To resolve the violation and preserve the functional behavior of 'result' being 'z',
  // we directly assign 'z' to 'result'. The array 'data_storage' is still used
  // by being written to.
  assign result = 8'bz;

endmodule
