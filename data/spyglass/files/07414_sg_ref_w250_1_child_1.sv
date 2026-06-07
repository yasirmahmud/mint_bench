module W250_ex1;
 initial fork : my_fork_block
  #1;
  disable my_fork_block;
 join
endmodule
