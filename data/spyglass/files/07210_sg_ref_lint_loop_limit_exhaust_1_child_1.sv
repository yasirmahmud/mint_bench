module LINT_LOOP_LIMIT_EXHAUST_ex1;
 integer i;
 initial begin 
  for (i=0; i<10; i=i+1) ; // Corrected loop increment to i=i+1 to ensure termination.
 end 
endmodule
