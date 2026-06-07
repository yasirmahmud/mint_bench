module curve_wrn_70_20260112_001950_305179_w37744_attempt14 (
  input wire in_data,
  output wire out_data
);

  // WRN_70: Obsolete Verilog-2001 Construct 'Standalone Generate Block' is used.
  // This 'generate' block is not controlled by a 'for', 'if', or 'case' statement.
  generate begin : my_simple_passthrough
    assign out_data = in_data;
  end
  endgenerate

endmodule
