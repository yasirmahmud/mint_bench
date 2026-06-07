module debug_init_assign_ex2 (
  output reg [7:0] my_vec
);
  // The original initial block logic:
  //   my_vec = 8'hFF; // 1111_1111
  //   my_vec[3:0] = 4'h0; // 1111_0000
  // This results in my_vec being 8'hF0.
  // The attempt to initialize 'my_vec' directly with 'reg [7:0] my_vec = 8'hF0;'
  // caused SYNTH_89 (ignored by synthesis) and WRN_40 (re-declaration)
  // because 'my_vec' is already declared as 'output reg' in the port list.
  // This initial block restores the intended simulation-time-zero value
  // and resolves the listed SpyGlass violations (SYNTH_89 and WRN_40).
  initial begin
    my_vec = 8'hF0;
  end

endmodule
