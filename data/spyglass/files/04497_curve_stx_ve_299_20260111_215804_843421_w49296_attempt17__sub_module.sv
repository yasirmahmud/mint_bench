module sub_module;
  parameter P = 0; // P is a scalar parameter
  // Use P to ensure the module is not considered empty and P is connected
  localparam LP_PARAM_PLUS_ONE = P + 1;
endmodule
