module load_module_ex1 (input in_load);
  // Dummy logic to read 'in_load' and resolve W240 (input not read) and 'empty definition' warnings.
  wire dummy_internal_load_wire;
  assign dummy_internal_load_wire = in_load;
endmodule
