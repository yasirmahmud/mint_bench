module w481b_ex1;
 integer j; // Changed 'j' to type integer (W480). 'i' was removed as it was unused (W528) and caused the W481b violation.
 initial begin
  for (j = 0; j < 10; j = j + 1) begin // Fixed W481b by making 'j' the sole loop variable for initialization, condition, and step.
   $display("j = %0d", j);
  end
 end
endmodule
