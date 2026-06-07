module top_module_ex2;
  parameter RESET_VAL = 1'b0;
  // Connect the new dummy_out port to an unconnected port syntax.
  child_module inst_child (.rst(RESET_VAL), .dummy_out());
endmodule
