module task_comment_ex1;
 reg a;
 // synopsys translate_off
 initial begin
  my_task(a);
  $display("Value of a after task: %0d", a);
 end
 // synopsys translate_on

 wire debug_a = a; // Added to resolve W528 by providing a synthesizable 'read' for 'a'

 task my_task(output reg out_a);
  begin
   out_a = 1;
  end
 endtask

endmodule
