module curve_stx_ve_605_20260111_174041_627610_w47100_attempt6 ();

  parameter MY_CONSTANT = 10;

  initial begin
    // Illegal attempt to assign a new value to a parameter in a procedural block.
    MY_CONSTANT = 20; 
  end

endmodule
