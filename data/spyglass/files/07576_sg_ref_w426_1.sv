module W426_ex1;
 reg global_var;
 task set_global;
 global_var = 1'b1;
 endtask initial begin set_global;
 end endmodule
