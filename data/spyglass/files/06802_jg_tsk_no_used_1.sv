module unused_task_module;
  input clk;
  output reg dummy_out;

  task my_unused_task;
    input int value;
    begin
      $display("Task called with value: %0d", value);
    end
  endtask

  always @(posedge clk) begin
    dummy_out <= 1'b0; // Dummy logic, task is not called
  end

endmodule
