module curve_stx_ve_1232_module_5;
  // STX_VE_1232: This declaration attempts to instantiate an array
  // of 'custom_protocol_if', which is an undefined type. Since
  // 'custom_protocol_if' is not a built-in Verilog type or a
  // previously declared user-defined type/module/interface, SpyGlass
  // might interpret this as an invalid SystemVerilog interface array
  // declaration in a context where interface types are expected to be defined,
  // thus triggering STX_VE_1232 for an "unknown type".
  custom_protocol_if protocol_instances_array[5];

endmodule
