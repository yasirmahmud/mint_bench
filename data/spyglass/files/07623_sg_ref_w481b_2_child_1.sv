module W481b_ex2;
 integer k; // Changed 'k' from reg to integer to resolve W480. 'i' is removed as it was unused and contributed to W481b and W528.
 initial begin
  // The for loop is corrected to use 'k' consistently as the loop control variable.
  // This resolves W481b (Init variable 'i' is not same as step variable 'k')
  // and W528 (Variable 'i' set but not read) by removing 'i' from the loop and its declaration.
  for (k = 0; k < 10; k = k + 1) begin
  end
 end
endmodule
