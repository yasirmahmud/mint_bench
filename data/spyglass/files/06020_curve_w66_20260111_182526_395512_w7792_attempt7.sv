module curve_w66_20260111_182526_395512_w7792_attempt7 (
  output reg [7:0] data_accumulator
);

  reg [2:0] loop_iterations;

  initial begin
    // Assign a non-constant value to the repeat expression variable.
    loop_iterations = 3'd3; 
    data_accumulator = 8'h0; // Initialize output register

    // W66 violation: The 'repeat' loop's expression 'loop_iterations' is not a constant.
    // This makes the repeat loop unsynthesizable.
    repeat (loop_iterations) begin
      data_accumulator = data_accumulator + 1; // Perform a simple operation inside the loop
    end
  end

endmodule
