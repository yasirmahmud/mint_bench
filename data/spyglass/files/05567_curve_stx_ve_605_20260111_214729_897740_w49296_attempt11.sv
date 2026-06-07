module curve_stx_ve_605_20260111_214729_897740_w49296_attempt11 ();

  parameter DATA_WIDTH = 8; // Declare a parameter

  initial begin
    // STX_VE_605 violation: Illegal attempt to assign a new value
    // to a parameter (DATA_WIDTH) within a procedural block (initial).
    DATA_WIDTH = 16;
  end

endmodule
