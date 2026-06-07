module top_ex1 ();
 tri my_tri_net;
 IO_CELL u_io (.pad_io(my_tri_net));
 INTERNAL_BLOCK u_internal (.internal_data(my_tri_net));
 endmodule
