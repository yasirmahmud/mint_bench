module w427_ex2;
 reg [7:0] global_data;
 task my_task;
 reg [7:0] local_var;
 begin local_var = global_data;
 end endtask endmodule
