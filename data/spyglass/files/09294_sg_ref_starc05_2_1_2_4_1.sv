module star_c05_2_1_2_4_ex1();
 reg a;
 task my_task;
 begin a = ~a;
 end endtask initial begin a = 1'b0;
 #10 my_task;
 end endmodule
