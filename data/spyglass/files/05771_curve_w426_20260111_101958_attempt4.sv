module curve_w426_20260111_101958_attempt4 (
    input wire enable,
    input wire data_in,
    output reg output_data
);

  // SpyGlass Rule W426: Global variable should not be 'set' in task
  task set_output_task;
    input enable_task;
    input data_task;
    if (enable_task) begin
      output_data = data_task; // This assignment triggers W426
    end else begin
      output_data = 1'b0;
    end
  endtask

  // The task is called within a combinatorial 'always' block.
  // Using a blocking assignment ('=') in the task, called from a combinatorial block,
  // is the core of this example to trigger W426 distinctly.
  always @* begin
    set_output_task(enable, data_in);
  end

endmodule
