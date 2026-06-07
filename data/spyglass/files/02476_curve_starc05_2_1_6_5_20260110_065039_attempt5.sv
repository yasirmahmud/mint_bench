module curve_starc05_2_1_6_5_20260110_065039_attempt5 (
  input clk,
  input reset_n,
  output [7:0] dummy_out
);

  reg [7:0] data_array [0:3];

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      // Reset all array elements to a known state to prevent uninitialized warnings
      data_array[0] <= 8'h00;
      data_array[1] <= 8'h00;
      data_array[2] <= 8'h00;
      data_array[3] <= 8'h00;
    end else begin
      // Target violation: Using 'x' as an array index for writing
      // STARC05-2.1.6.5: For an array index x and z should not be used
      data_array[2'bx] <= 8'hFF;

      // Other elements of data_array implicitly hold their values, which is standard
      // behavior for registers in a sequential block when not explicitly assigned.
    end
  end

  // Assign to an output and read an element of data_array to prevent
  // unused signal warnings (e.g., W528) for data_array and dummy_out.
  assign dummy_out = data_array[0];

endmodule
