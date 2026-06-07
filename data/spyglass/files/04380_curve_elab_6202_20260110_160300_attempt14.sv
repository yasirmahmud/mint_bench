module curve_elab_6202_20260110_160300_attempt14 ();

  reg [31:0] counter;

  initial begin
    // ELAB_6202: Infinite for loop found in the design
    // This 'for' loop is designed to be mathematically infinite.
    // The loop condition '1'b1' is always true, meaning the loop will never terminate.
    // When the 'initial' block is elaborated and executed at time 0, this loop will run indefinitely.
    for (counter = 0; 1'b1; counter = counter + 1) begin
      // An empty loop body is valid and minimal. The infinite nature is solely in the loop condition.
    end
  end

endmodule
