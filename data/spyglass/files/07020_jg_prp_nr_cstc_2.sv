module constant_clock_assertion_2 ();

  property p_another_always_true;
    @(posedge 1'b1) (1);
  endproperty

  assert property (p_another_always_true);

endmodule
