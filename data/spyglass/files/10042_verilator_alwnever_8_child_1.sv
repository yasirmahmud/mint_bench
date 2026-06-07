module example_8;
  reg [63:0] large_reg;
  // To resolve Verilator's ALWNEVER warning (implicit in description),
  // and ensure the intended initialization, change always @* to initial.
  initial begin
    large_reg = 64'hDEADBEEF_CAFEBABE;
  end

  // To resolve SpyGlass W528 "Variable 'large_reg' set but not read",
  // add a dummy read. This preserves functional behavior as 'large_reg'
  // is an internal signal not otherwise connected.
  wire [63:0] large_reg_read_dummy; // Declare a dummy wire
  assign large_reg_read_dummy = large_reg; // Perform a dummy read

endmodule
