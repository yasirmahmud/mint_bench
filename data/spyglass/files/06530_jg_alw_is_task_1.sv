module task_in_always_ex1 (
  input clk,
  input enable,
  output reg out_signal
);

  task my_simple_task;
    begin
      #1; // Time-controlling statement
      out_signal = ~out_signal;
    end
  endtask

  always @(posedge clk) begin
    if (enable) begin
      my_simple_task; // Task used in always block
    end
  end

endmodule
