module load_module_ex1 (input in_load);
  // The original dummy logic (wire dummy_internal_load_wire; assign dummy_internal_load_wire = in_load;)
  // was removed to resolve W528 ('dummy_internal_load_wire' set but not read).
  // 'in_load' is now implicitly considered 'read' by being an input to this module.
  // If W240 (input not read) or 'empty definition' warnings emerge without this dummy logic,
  // tool-specific pragmas or more robust dummy logic would be required.
endmodule
