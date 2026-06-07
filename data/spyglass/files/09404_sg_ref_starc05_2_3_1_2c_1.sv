primitive toggle_ff_ex1 (q, clk);
 output q;
 input clk;
 reg q;
 table (posedge clk) ? : ~q;
 (negedge clk) ? : ~q;
 endtable endprimitive module top_ex1;
 reg my_q;
 wire my_clk;
 toggle_ff_ex1 u_ff (my_q, my_clk);
 endmodule
