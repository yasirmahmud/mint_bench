module task_comment_ex1;
 reg a;
 initial begin
  my_task(a);
  $display("Value of a after task: %0d", a);
 end

 task my_task(output reg out_a);
  begin
   out_a = 1;
  end
 endtask

endmodule
