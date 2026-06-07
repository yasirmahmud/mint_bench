module curve_starc05_2_1_6_5_20260110_161304_attempt8 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Declare a 4-element array of 8-bit registers
  reg [7:0] my_array [0:3];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Reset all array elements and output
      my_array[0] <= 8'h00;
      my_array[1] <= 8'h00;
      my_array[2] <= 8'h00;
      my_array[3] <= 8'h00;
      data_out <= 8'h00;
    end else begin
      // On positive clock edge, perform operations
      my_array[0] <= data_in;
      my_array[1] <= data_in;
      my_array[2] <= data_in;
      my_array[3] <= data_in;

      // STARC05-2.1.6.5 violation: Using 'z' as an array index
      // The array has 4 elements, so a 2-bit index is appropriate (e.g., 2'b00 to 2'b11).
      my_array[2'bz] <= 8'hAA;

      // Assign data_out to ensure it is always driven and 'my_array' is used
      data_out <= my_array[0];
    end
  end

endmodule
