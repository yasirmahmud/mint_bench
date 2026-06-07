module parent_module ();
  wire p_in;
  wire [2:0] p_out; // Fixed: Changed width to [2:0] to match child_module.out_result (3 bits)

  assign p_in = 1'b0;

  child_module u_child (
    .in_data (p_in),
    .out_result (p_out)
  );
endmodule
