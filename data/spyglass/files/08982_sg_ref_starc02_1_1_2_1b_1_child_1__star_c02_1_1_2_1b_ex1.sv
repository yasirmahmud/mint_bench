module star_c02_1_1_2_1b_ex1();
 wire unused_b; // Declare a dummy wire for the unconnected output
 my_sub_module i (.a(1'b0), .b(unused_b)); // Connect the output port 'b' to the dummy wire
 endmodule
