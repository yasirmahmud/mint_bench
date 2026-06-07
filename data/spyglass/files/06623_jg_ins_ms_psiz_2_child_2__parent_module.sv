module parent_module ();
  wire p_in;
  wire [2:0] p_out;
  wire [2:0] p_out_consumed; // Added to consume p_out and resolve W528

  assign p_in = 1'b0;
  assign p_out_consumed = p_out; // Reading p_out to resolve W528

  child_module u_child (
    .in_data (p_in),
    .out_result (p_out)
  );
endmodule
