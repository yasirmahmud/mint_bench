module top_ex1 (input in_dummy, output out_dummy);
 wire internal_wire;
 sub_ex1 u_sub (.out_undriven (internal_wire));
 load_module_ex1 u_load (.in_load (internal_wire));
 assign out_dummy = in_dummy;
 endmodule
