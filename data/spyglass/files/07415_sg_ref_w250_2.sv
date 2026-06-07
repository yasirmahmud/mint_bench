module w250_ex2 (input trigger);
 initial begin : my_fork_block fork begin #10;
 end begin if (trigger) disable my_fork_block;
 end join end endmodule
