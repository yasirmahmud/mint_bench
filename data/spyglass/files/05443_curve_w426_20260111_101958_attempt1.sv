module curve_w426_20260111_101958_attempt1 (
    input wire clk,
    output reg out_signal
);

  // SpyGlass Rule W426: Global variable 'out_signal' should not be 'set' in task
  task update_output_task;
    out_signal <= 1'b0; // This assignment triggers W426
  endtask

  always @(posedge clk) begin
    update_output_task; // Call the task to make the design functionally complete
  end

endmodule
