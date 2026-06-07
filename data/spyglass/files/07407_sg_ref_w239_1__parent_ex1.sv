module parent_ex1 (input p_in, output p_out);
 wire p_internal;
 child_module c1 (.c_out(p_out));
 assign p_internal = p_in;
 endmodule
