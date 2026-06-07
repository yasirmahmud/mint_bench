module cascaded_ex1();
 wire w_in;
 wire w_inter;
 wire w_out;
 my_buf_module_ex1 U1 (.a(w_in), .z(w_inter));
 my_buf_module_ex1 U2 (.a(w_inter), .z(w_out));
 endmodule
