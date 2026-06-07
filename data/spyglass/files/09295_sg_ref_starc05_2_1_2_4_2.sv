module stac05_2_1_2_4_ex2;
 reg [7:0] data;
 task my_task;
 begin data = 8'hFF;
 end endtask initial begin my_task;
 end endmodule
