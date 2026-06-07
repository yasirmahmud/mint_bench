module top_module_1 ();
  wire my_flag;

  child_module u_child (
    .in_data(8),
    .out_flag(my_flag)
  );
endmodule
