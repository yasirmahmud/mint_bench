module starc02_2_9_2_3_ex1 (
  input clk,
  input [7:0] my_data [0:15],
  output reg out_flag
);

  integer i;
  reg next_out_flag;

  always @(posedge clk) begin
    // Initialize the temporary flag to 0 for the current clock cycle
    next_out_flag = 1'b0; // Only one assignment to 0

    // Loop through the data array to determine the next_out_flag
    // If any my_data[i] > 8'd5, set next_out_flag to 1 and break from the loop.
    // This ensures 'next_out_flag' is assigned to 1'b1 at most once per clock cycle,
    // resolving the W415a violation while preserving functional behavior.
    for (i = 0; i < 12; i = i + 1) begin
      if (my_data[i] > 8'd5) begin
        next_out_flag = 1'b1; // Only one assignment to 1
        break; // Exit loop immediately once condition is met
      end
    end

    // Assign the calculated next state to the output register using a non-blocking assignment
    out_flag <= next_out_flag;
  end

endmodule
