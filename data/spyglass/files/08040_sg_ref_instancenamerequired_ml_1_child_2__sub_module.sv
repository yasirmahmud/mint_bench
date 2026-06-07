module sub_module();
  // Adding a dummy declaration to resolve "Design Unit 'sub_module' has empty definition" warning
  wire dummy_wire;
  // Adding an assign statement to ensure the module is not considered empty by linting tools.
  assign dummy_wire = 1'b0;
endmodule
