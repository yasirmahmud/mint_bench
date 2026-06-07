module example_10(output reg j);
  task automatic my_task;
    j = 1'b1;
  endtask
  initial my_task;
endmodule
