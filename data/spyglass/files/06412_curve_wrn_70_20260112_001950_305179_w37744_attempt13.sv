module curve_wrn_70_20260112_001950_305179_w37744_attempt13 (
  input wire in_a,
  output reg out_z
);

  // WRN_70: Obsolete Verilog-2001 Construct 'Standalone Generate Block' is used
  // This 'generate' block is not controlled by a 'for', 'if', or 'case' statement.
  generate begin : my_standalone_combinational_block
    always @* begin
      out_z = !in_a; // Simple inverter logic
    end
  end
  endgenerate

endmodule
