module W346_ex1;
 reg clk_sig;
 task my_task_ex1;
 input a;
 output b;
 begin @(posedge clk_sig);
 b = a;
 @(negedge clk_sig);
 b = ~a;
 end endtask endmodule
