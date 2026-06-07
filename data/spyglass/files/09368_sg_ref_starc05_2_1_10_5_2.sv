module star_c05_2_1_10_5_ex2 (input a, output reg b);
 task my_proc;
 begin b = ~a;
 end endtask always @(a) begin my_proc;
 end endmodule
