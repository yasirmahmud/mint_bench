module constant_clock_assertion_1 ();
  localparam CLK_CONST = 1'b0; // Constant clock signal

  property p_always_true;
    @(posedge CLK_CONST) (1);
  endproperty

  assert property (p_always_true);

endmodule
