primitive dual_clk_ff_ex2 (q, d, clk_a, clk_b);
 output q;
 input d, clk_a, clk_b;
 reg q;
 table
 // d clk_a clk_b : q : next_q
 1 (01) ? : ? : 1;
 0 (01) ? : ? : 0;
 1 ? (01) : ? : 1;
 0 ? (01) : ? : 0;
 ? * * : ? : -;
 endtable
endprimitive

module top_module_ex2;
 endmodule
