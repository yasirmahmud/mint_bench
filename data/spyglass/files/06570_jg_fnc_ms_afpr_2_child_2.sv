module task_width_mismatch (
  input clk,
  input rst_n
);
  task my_task (input [0:0] formal_param);
    $display("Task received: %b", formal_param);
  endtask

  localparam [7:0] ACTUAL_VALUE = 8'hAB;

  reg task_called;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      task_called <= 1'b0;
    end else begin
      if (!task_called) begin
        my_task(ACTUAL_VALUE[0]);
        task_called <= 1'b1;
      end
    end
  end
endmodule
