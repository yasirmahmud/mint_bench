module curve_stx_ve_605_20260111_214729_897740_w49296_attempt12 ();

  // Changed from localparam to reg to allow assignment in a procedural block.
  // This resolves the STX_VE_605 violation and preserves the intent to assign a value to CONFIG_VALUE.
  reg CONFIG_VALUE = 10; // Declare a reg, initialized to 10

  // An always block provides a procedural context.
  always @(*) begin
    // The assignment to CONFIG_VALUE is now legal as it is a reg.
    CONFIG_VALUE = 20;
  end

endmodule
