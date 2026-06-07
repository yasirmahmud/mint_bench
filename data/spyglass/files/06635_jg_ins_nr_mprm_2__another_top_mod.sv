module another_top_mod;
  // This instance provides three positional parameters, but 'another_sub_mod' only has two.
  another_sub_mod #(5, 10, 15) inst_too_many_pos_params();
endmodule
