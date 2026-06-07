module starc02_2_9_2_3_ex1 (
  input clk,
  input [7:0] my_data [0:15], // Made my_data an input to resolve undriven signal violations
  output reg out_flag
);

  integer i;
  reg next_out_flag; // Temporary register for calculating the next state of out_flag

  always @(posedge clk) begin
    // Initialize the temporary flag to 0 for the current clock cycle
    next_out_flag = 1'b0;

    // Loop through the data array to determine the next_out_flag
    // If any my_data[i] > 8'd5, set next_out_flag to 1
    for (i = 0; i < 12; i = i + 1) begin
      if (my_data[i] > 8'd5) begin
        next_out_flag = 1'b1; // Blocking assignment to temporary register is acceptable
      end
    end

    // Assign the calculated next state to the output register using a non-blocking assignment
    // This resolves W336 (blocking assignment in sequential block) and W415a (multiple assignments)
    out_flag <= next_out_flag;
  end

endmodule
