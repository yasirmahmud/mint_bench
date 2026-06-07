module child_module_ex1 (input data_in);
 // The 'unused_data_in' wire and its assignment were removed because
 // they were introduced as a workaround but resulted in a W528 violation
 // (variable set but not read). Removing them resolves the W528 violation
 // and preserves the null functional behavior of this module.
 endmodule
