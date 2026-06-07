module another_top_mod;
  // This instance provides three positional parameters, but 'another_sub_mod' only has two.
  // Fixed by removing the extraneous third positional parameter.
  another_sub_mod #(5, 10) inst_too_many_pos_params();
endmodule
