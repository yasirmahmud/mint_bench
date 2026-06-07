module same_loop_index_ex1(output reg out1, output reg out2);
  integer k1; // Changed to integer and unique loop index for the first always block
  integer k2; // Changed to integer and unique loop index for the second always block

  always @* begin
    reg temp_out1; // Use a temporary variable to accumulate result and avoid W415a
    temp_out1 = 1'b0;
    for (k1 = 0; k1 < 2; k1 = k1 + 1) begin
      temp_out1 = temp_out1 | (k1 == 1);
    end
    out1 = temp_out1; // Assign to the actual output only once
  end

  always @* begin
    reg temp_out2; // Use a temporary variable to accumulate result and avoid W415a
    temp_out2 = 1'b0;
    for (k2 = 0; k2 < 3; k2 = k2 + 1) begin
      temp_out2 = temp_out2 | (k2 == 2);
    end
    out2 = temp_out2; // Assign to the actual output only once
  end
endmodule
