module sub_module #(
  parameter P = 0 // P is a scalar integer parameter, default 32-bit
) (
  output wire dummy_out
);
  // Access a bit of P to ensure P is used, preventing unused signal warnings.
  // This usage does not introduce other violations.
  assign dummy_out = P[0];
endmodule
