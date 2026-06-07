module top_ex1 ();
 wire dummy_in_a = 1'b0;
 wire dummy_in_b = 1'b0;
 wire vdd_net; // Fixed: Removed implicit assignment 1'b1 to resolve W415
 wire gnd_net; // Fixed: Removed implicit assignment 1'b0 to resolve W415
 my_cell inst_vdd (.a(dummy_in_a), .b(dummy_in_b), .z(vdd_net));
 my_cell inst_gnd (.a(dummy_in_a), .b(dummy_in_b), .z(gnd_net));
 // Removed 'unused_vdd_sink' and 'unused_gnd_sink' and their assignments to resolve W528 violations.
 endmodule
