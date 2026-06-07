module CELL_WITH_INOUT_ex1 (input in_a, inout io_b, output out_x);
 assign out_x = in_a ^ io_b;
 endmodule
