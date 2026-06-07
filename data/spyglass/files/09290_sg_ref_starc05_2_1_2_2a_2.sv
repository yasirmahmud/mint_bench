module star_c05_2_1_2_2a_ex2;
 reg my_reg;
 task my_task;
 input val;
 begin my_reg <= val;
 end endtask initial begin my_task(1'b1);
 end endmodule
