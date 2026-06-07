module curve_w426_20260111_225856_747181_w28836_attempt11 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] data_output
);

  // This task modifies a module-level variable 'data_output'.
  // SpyGlass rule W426 flags assignments to 'global' (module-scope) variables from within a task.
  task update_data_output;
    data_output = 8'hAA; // W426: Global variable 'data_output' should not be 'set' in task
  endtask

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_output <= 8'h00; // Reset assignment
    end else begin
      update_data_output; // Call the task which triggers the W426 violation
    end
  end

endmodule
