module curve_stx_ve_605_20260111_214729_897740_w49296_attempt12 ();

  localparam CONFIG_VALUE = 10; // Declare a localparam

  // An always block provides a procedural context.
  always @(*) begin
    // STX_VE_605 violation: Illegal attempt to assign a new value
    // to a localparam (CONFIG_VALUE) within a procedural block.
    CONFIG_VALUE = 20;
  end

endmodule
