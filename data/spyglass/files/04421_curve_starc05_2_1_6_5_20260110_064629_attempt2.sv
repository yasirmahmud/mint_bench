module curve_starc05_2_1_6_5_20260110_064629_attempt2 (
  output reg [7:0] data_out
);

  reg [7:0] my_array [0:3];

  initial begin
    // Triggers STARC05-2.1.6.5: For an array index x and z should not be used
    my_array[2'bx] = 8'hAA;

    // Read from the array to prevent W528 (variable set but not read) for 'my_array'
    // 'data_out' is an output port, so it is considered 'read' externally,
    // preventing W528 for 'data_out' itself.
    data_out = my_array[0];
  end

endmodule
