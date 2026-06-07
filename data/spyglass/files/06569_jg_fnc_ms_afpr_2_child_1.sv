module task_width_mismatch;
  task my_task (input [0:0] formal_param);
    $display("Task received: %b", formal_param);
  endtask

  reg [7:0] actual_value = 8'hAB;

  initial begin
    my_task(actual_value[0]); // Explicitly pass the LSB to match the 1-bit formal parameter
  end
endmodule
