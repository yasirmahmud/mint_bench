module sub_module_ex2 (output sub_out);
  assign sub_out = 1'b0; // Drive the output to resolve "empty definition" and "undriven output" warnings.
endmodule
