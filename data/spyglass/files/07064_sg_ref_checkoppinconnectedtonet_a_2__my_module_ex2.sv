module my_module_ex2 ();
 wire dangling_q;
 my_cell i_gate (.in1(1'b0), .in2(1'b0), .out(dangling_q));
 endmodule
