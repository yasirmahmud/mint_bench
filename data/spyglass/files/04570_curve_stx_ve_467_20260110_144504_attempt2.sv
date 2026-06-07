module curve_stx_ve_467_20260110_144504_attempt2 (
  input wire clk,
  input wire rst_n,
  input wire [15:0] data_in_packed,
  output reg [7:0] out_unpacked_slice
);

  // Declare an unpacked array of 8-bit registers, 2 elements
  reg [7:0] my_unpacked_array [0:1];

  // Declare a packed array of 16 bits
  reg [15:0] my_packed_array;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_unpacked_array[0] <= 8'h00;
      my_unpacked_array[1] <= 8'h00;
      my_packed_array <= 16'h0000;
    end else begin
      // Assign input to packed array for usage
      my_packed_array <= data_in_packed;

      // Assign an element of the unpacked array from input, for usage
      my_unpacked_array[0] <= data_in_packed[7:0];

      // STX_VE_467 violation: Assigning a packed array (my_packed_array)
      // to an unpacked array (my_unpacked_array). These are non-equivalent data types.
      my_unpacked_array <= my_packed_array; // Violation point
    end
  end

  // Drive the output to ensure my_unpacked_array is used
  assign out_unpacked_slice = my_unpacked_array[1]; 

endmodule
