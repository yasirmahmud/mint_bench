module top_ex2();
 wire my_sig;
 MY_LIB_CELL u_my_lib_cell (.PORT(my_sig)); // Fix: Added instance name 'u_my_lib_cell'
 endmodule
