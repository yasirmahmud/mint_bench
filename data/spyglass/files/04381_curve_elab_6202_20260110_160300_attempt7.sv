module curve_elab_6202_20260110_160300_attempt7 ();

  integer i;

  initial begin
    for (i = 0; i < 10; i = i - 1) begin
      // This loop will never terminate because 'i' is an integer (signed by default).
      // It starts at 0, then goes -1, -2, -3, ... and will always be less than 10.
      $display("Infinite loop iteration: %d", i);
    end
  end

endmodule
