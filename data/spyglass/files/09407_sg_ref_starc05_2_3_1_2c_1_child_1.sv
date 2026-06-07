primitive toggle_ff_ex1 (q, clk);
 output q;
 input clk;
 reg q;
 table
  // clk current_q : next_q
  (posedge clk) 0 : 1;
  (posedge clk) 1 : 0;
  (posedge clk) x : x;
  (negedge clk) 0 : 1;
  (negedge clk) 1 : 0;
  (negedge clk) x : x;
  // For all other cases (e.g., clock is stable level 0, 1, x), output q does not change.
  0 ? : -;
  1 ? : -;
  x ? : -;
 endtable
endprimitive

module top_ex1;
 reg my_q;
 wire my_clk;
 toggle_ff_ex1 u_ff (my_q, my_clk);
endmodule
