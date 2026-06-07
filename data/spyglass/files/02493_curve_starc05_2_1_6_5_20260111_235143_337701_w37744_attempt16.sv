module curve_starc05_2_1_6_5_20260111_235143_337701_w37744_attempt16 (
  output [7:0] data_out
);

  // Declare a register array. It has 16 elements, each 8 bits wide.
  // This requires a 4-bit index (0 to 15).
  reg [7:0] data_storage [0:15];

  // Internal signal to provide data, avoiding external inputs.
  // It's a simple constant to ensure it's driven and used.
  reg [7:0] internal_data = 8'h55;

  // Use a combinational always block to ensure all elements of 'data_storage'
  // are assigned a value under all conditions. This prevents latches and
  // 'undriven' warnings for array elements.
  always @(*) begin
    integer i;
    for (i = 0; i < 16; i = i + 1) begin
      data_storage[i] = internal_data + i; // Assign a unique value to each element
    end
  end

  // This continuous assignment directly triggers the STARC05-2.1.6.5 violation:
  // "For an array index x and z should not be used".
  // The 'x' value in the 4-bit index '4'bx' is the cause of the violation.
  // 'data_out' is driven by this read, ensuring the output signal is used.
  // 'data_storage' is read from, ensuring the array is used.
  assign data_out = data_storage[4'bx];

endmodule
