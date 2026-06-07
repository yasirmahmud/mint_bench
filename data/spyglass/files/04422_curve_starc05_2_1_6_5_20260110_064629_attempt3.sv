module curve_starc05_2_1_6_5_20260110_064629_attempt3 (
  output reg [7:0] data_out
);

  // Declare a memory (array of registers)
  reg [7:0] my_array [0:3];

  // Declare a wire and assign an 'x' value to it. This wire will be used as an array index.
  wire [1:0] bad_index_wire = 2'bx;

  // Use an always block to assign to an element of the array using the 'x'-valued index.
  // This directly triggers STARC05-2.1.6.5 as it uses 'x' in an array index.
  always @* begin
    my_array[bad_index_wire] = 8'hAA; // STARC05-2.1.6.5 violation here
  end

  // Drive the output port and read from 'my_array' to avoid unused signal warnings
  // for both 'data_out' and 'my_array'. Reading from a known good index (0) is safe.
  assign data_out = my_array[0];

endmodule
