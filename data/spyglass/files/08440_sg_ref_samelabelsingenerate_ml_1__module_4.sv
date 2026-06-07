genvar i;
 generate for (i = 0; i < 1; i = i + 1) begin : gen_for_1 my_inst_label: mod_A inst_a (.a(in_sig));
 end endgenerate generate for (i = 0; i < 1; i = i + 1) begin : gen_for_2 my_inst_label: mod_B inst_b (.b(in_sig));
 end endgenerate endmodule
