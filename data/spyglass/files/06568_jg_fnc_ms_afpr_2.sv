module task_width_mismatch;
  task my_task (input [0:0] formal_param);
    $display("Task received: %b", formal_param);
  endtask

  reg [7:0] actual_value = 8'hAB;

  initial begin
    my_task(actual_value); // Formal is 1-bit, actual is 8-bit
  end
endmodule
