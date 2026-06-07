module incremental_for_loop_ex1;
 integer i;
 // synthesis translate_off
 initial begin for (i = 0; i < 10; i++) begin end end
 // synthesis translate_on
endmodule
