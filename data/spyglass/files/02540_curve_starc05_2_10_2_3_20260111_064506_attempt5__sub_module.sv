module sub_module (
  input wire one_bit_in
);
  // This module just consumes the input to avoid unused signal warnings
  // In a real scenario, this input would drive some logic.
  wire dummy_internal = one_bit_in; // Ensure the input is used
endmodule
