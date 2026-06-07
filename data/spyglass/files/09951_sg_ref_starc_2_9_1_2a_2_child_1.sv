module star_2_9_1_2a_ex2 (input [7:0] data_in, output reg [7:0] data_out);

  always @(*) begin
    // Initialize data_out to 0 to prevent latches for bits that are not assigned
    // by the conditional logic (i.e., when k < data_in). This resolves the
    // implicit latch inference and makes the design fully synthesizable.
    data_out = 8'b0;

    // Iterate through all possible bit indices from 0 to 7.
    // This for loop has fixed, synthesizable bounds, resolving the SYNTH_5230 violation.
    for (integer k = 0; k < 8; k = k + 1) begin
      // Apply the original condition: data_out[k] is assigned data_in[k] only if
      // k is greater than or equal to the starting index specified by data_in.
      // This maintains the functional behavior of the original loop's assignments.
      if (k >= data_in) begin
        data_out[k] = data_in[k];
      end
    end
  end
endmodule
