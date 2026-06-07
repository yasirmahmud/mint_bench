module curve_starc05_2_1_6_5_20260110_064629_attempt3 (
  output reg [7:0] data_out
);

  reg [7:0] my_array [0:3];

  // Changed '2'bx' to a valid index '2'd0' to resolve 'NoAssignX-ML' violation.
  // This also ensures 'my_array[0]' is always assigned, preventing 'InferLatch' violation.
  wire [1:0] bad_index_wire = 2'd0;

  always @* begin
    // With 'bad_index_wire' now being '2'd0', my_array[0] is consistently assigned.
    my_array[bad_index_wire] = 8'hAA;
  end

  // Driving the output port and reading from 'my_array' remains the same.
  assign data_out = my_array[0];

endmodule
