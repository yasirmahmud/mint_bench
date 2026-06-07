module curve_starc05_2_1_6_5_20260111_235143_337701_w37744_attempt15 (
  input clk,
  input reset_n,
  input [7:0] data_in,
  output [7:0] data_out
);

  // Declare a reg array to simulate a small memory block.
  // It has 8 elements, each 8 bits wide. Requires a 3-bit index.
  reg [7:0] my_mem [0:7];

  // Drive the memory array in a clocked always block to avoid latches
  // and ensure its elements are used and defined. All elements are written to
  // during reset, and then elements 0 and 1 are written to during normal operation.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      // Reset all elements to 0 to ensure full assignment and avoid latches.
      for (integer i = 0; i < 8; i = i + 1) begin
        my_mem[i] <= 8'h00;
      end
    end else begin
      // Example write operation to an element based on data_in.
      my_mem[0] <= data_in;
      // Write to another element to ensure general usage of the array
      // and avoid potential unused signal warnings for array elements.
      my_mem[1] <= 8'hAA;
    end
  end

  // This continuous assignment directly triggers the STARC05-2.1.6.5 violation:
  // "For an array index x and z should not be used".
  // The 'z' value in the index is the cause of the violation.
  // 'data_out' is driven by this read, ensuring the output signal is used.
  // 'my_mem' is read from, ensuring the array is used.
  assign data_out = my_mem[3'bz];

endmodule
