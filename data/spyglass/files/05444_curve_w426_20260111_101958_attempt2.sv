module curve_w426_20260111_101958_attempt2 (
    input wire clk,
    output reg data_out
);

  // SpyGlass Rule W426: Global variable 'data_out' should not be 'set' in task
  task set_output_task;
    // Using a blocking assignment for distinction from previous attempt
    // and as seen in context example 2.
    data_out = 1'b1; // This assignment triggers W426
  endtask

  always @(posedge clk) begin
    set_output_task; // Call the task to make the design functionally complete
  end

endmodule
