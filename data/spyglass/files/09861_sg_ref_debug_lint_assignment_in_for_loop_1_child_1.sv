module DEBUG_LINT_ASSIGNMENT_IN_FOR_LOOP_ex1;
 reg r1;
 integer i;
 always @(*) begin
  for (i=0; i<1; i=i+1) begin
   r1=0;
  end
 end
endmodule
