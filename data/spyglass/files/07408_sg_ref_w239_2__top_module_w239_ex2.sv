module top_module_w239_ex2 (input top_in, output top_out);
 wire top_internal_wire;
 sub_module_w239_ex2 u_sub (.in_s(top_in), .out_s(top_internal_wire));
 assign top_out = u_sub.internal_s;
 endmodule
