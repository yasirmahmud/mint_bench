module top_ex1 ();
 wire dummy_in_a = 1'b0;
 wire dummy_in_b = 1'b0;
 wire vdd_net = 1'b1;
 wire gnd_net = 1'b0;
 my_cell inst_vdd (.a(dummy_in_a), .b(dummy_in_b), .z(vdd_net));
 my_cell inst_gnd (.a(dummy_in_a), .b(dummy_in_b), .z(gnd_net));
 endmodule
