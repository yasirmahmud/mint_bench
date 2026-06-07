module parent_module ();
  wire p_in;
  wire [1:0] p_out; // Mismatch: child_module.out_result is 3 bits, p_out is 2 bits

  assign p_in = 1'b0;

  child_module u_child (
    .in_data (p_in),
    .out_result (p_out)
  );
endmodule
