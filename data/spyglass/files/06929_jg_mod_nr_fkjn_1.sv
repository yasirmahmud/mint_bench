module example_fork_join_1();
  initial begin
    $display("Starting parallel tasks...");
    fork
      #10 $display("Task 1 finished at 10ns");
      #5  $display("Task 2 finished at 5ns");
    join
    $display("All parallel tasks completed.");
  end
endmodule
