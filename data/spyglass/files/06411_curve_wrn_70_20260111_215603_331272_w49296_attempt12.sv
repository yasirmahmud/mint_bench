module curve_wrn_70_20260111_215603_331272_w49296_attempt12 (
  input input_data,
  output output_data
);

  // WRN_70: Obsolete Verilog-2001 Construct 'Standalone Generate Block' is used
  // This 'generate' block is not controlled by a 'for', 'if', or 'case' statement.
  generate begin : standalone_combinational_logic_v10
    // Declare a localparam and use it in an assign statement within the standalone generate block.
    localparam MY_CONSTANT = 4'b1010;
    wire intermediate_wire;

    // Simple combinational logic using the localparam
    assign intermediate_wire = input_data ? MY_CONSTANT[0] : 1'b0;

    // Output assignment
    assign output_data = intermediate_wire;

  end endgenerate

endmodule
