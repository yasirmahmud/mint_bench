module curve_synth_196_20260111_070206_attempt1 (
  input clk,
  input rst,
  input [7:0] data_in,
  output reg [7:0] data_out
);

  // Task definition with an event control statement
  task my_bad_task;
    input [7:0] task_data_in;
    output reg [7:0] task_data_out;
    begin
      // SYNTH_196 violation: Event control statement inside a task
      @(posedge clk);
      task_data_out = task_data_in;
    end
  endtask

  // Procedural block to use the task and avoid unused code warnings
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_out <= 8'b0;
    end else begin
      // Calling a task that contains an event control statement
      my_bad_task(data_in, data_out);
    end
  end

endmodule
