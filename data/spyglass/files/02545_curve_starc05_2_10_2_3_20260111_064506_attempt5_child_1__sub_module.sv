module sub_module (
  input wire one_bit_in
);
  // This module just consumes the input to avoid unused signal warnings
  // In a real scenario, this input would drive some logic.
  // The 'dummy_internal' wire has been removed to resolve W528 (set but not read).
  // The 'one_bit_in' port itself is considered used as an input to the module.
endmodule
