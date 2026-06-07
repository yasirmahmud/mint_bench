module curve_stx_ve_282_top (
  input wire top_data_in,
  output wire top_data_out
);

  // Instantiate sub_module.
  // The port named 'in' is used in the instance 'i_sub_module',
  // but it does not exist as a port in the definition of 'sub_module'.
  // 'sub_module' expects 'sub_data_in'. This causes STX_VE_282.
  sub_module i_sub_module (
    .in(top_data_in),       // This named port 'in' does not exist in 'sub_module'
    .sub_data_out(top_data_out) // This named port exists in 'sub_module'
  );

endmodule
