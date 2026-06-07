module curve_starc05_2_1_6_5_20260111_235143_337701_w37744_attempt14 (
  input [7:0] data_in,
  output reg [7:0] data_out
);

  // Declare a wire array. Elements are combinational.
  // Using a wire array avoids latch generation issues associated with partially assigned 'reg' arrays
  // when assigned in an always @* block or procedurally, adhering to Verilog-2001.
  wire [7:0] memory_bank [0:7]; // 8 elements, 8-bit wide, requires a 3-bit index

  // Continuously assign to elements of the wire array.
  // This ensures 'data_in' is used and 'memory_bank' is written to (thus used).
  assign memory_bank[0] = data_in;
  assign memory_bank[1] = 8'hAA; // Write to another element to ensure general usage and avoid warnings

  // The problematic assignment using 'x' in the index is within an always @* block.
  always @* begin
    // This statement directly triggers the STARC05-2.1.6.5 violation:
    // "For an array index x and z should not be used".
    // 'data_out' is driven by this read, ensuring the output signal is used.
    // 'memory_bank' is read from, ensuring the array is used.
    data_out = memory_bank[3'bx];
  end

endmodule
