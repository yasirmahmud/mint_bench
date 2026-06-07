module SameLabelsInGenerate_ex1 (input in_sig);
  genvar i;
  generate
    for (i = 0; i < 1; i = i + 1) begin : gen_for_1
      mod_A inst_a (.a(in_sig));
    end
  endgenerate
  generate
    for (i = 0; i < 1; i = i + 1) begin : gen_for_2
      mod_B inst_b (.b(in_sig));
    end
  endgenerate
endmodule
