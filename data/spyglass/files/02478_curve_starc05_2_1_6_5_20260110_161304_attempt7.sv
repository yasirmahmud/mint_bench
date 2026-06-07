module curve_starc05_2_1_6_5_20260110_161304_attempt7 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Declare a 4-element array of 8-bit registers
  reg [7:0] my_array [0:3];

  // Use an always @(*) block to ensure synthesizability and avoid initial block warnings.
  always @(*) begin
    // Drive all elements of 'my_array' with a known value to prevent
    // latch inference or 'variable set but not read' (W528) warnings.
    my_array[0] = data_in;
    my_array[1] = data_in;
    my_array[2] = data_in;
    my_array[3] = data_in;

    // Trigger STARC05-2.1.6.5: use 'x' as an array index.
    // This directly violates the rule which prohibits 'x' or 'z' in array indices.
    // Reading from the array also ensures 'my_array' is considered 'used'.
    data_out = my_array[2'bx];
  end

endmodule
