module top_module_ex1 (input clk, output out_data);
 wire internal_signal;
 CELL_WITH_INOUT_ex1 i1 (.in_a(clk), .io_b(internal_signal), .out_x(out_data));
 endmodule
