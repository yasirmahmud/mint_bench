module incremental_for_loop_ex2;
 integer i;
 initial begin for (i = 0; i < 10; i++) begin $display("i = %0d", i);
 end end endmodule
