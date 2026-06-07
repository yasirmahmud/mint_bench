module curve_starc05_2_1_6_5_20260110_065039_attempt4 (
  output [7:0] dummy_out
);

  reg [7:0] data_array [0:3];
  reg [7:0] internal_read;

  initial begin
    // Target violation: Using 'x' as an array index
    data_array[2'bx] = 8'hFF;
    // Read an element of data_array to prevent W528 (unused signal) for data_array
    internal_read = data_array[0];
  end

  // Assign to an output to prevent W528 (unused signal) for internal_read
  assign dummy_out = internal_read;

endmodule
