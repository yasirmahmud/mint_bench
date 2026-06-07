module top13;
  bit [7:0] data[0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] = 8'h11; // Changed from non-blocking '<=' to blocking '=' to resolve BLKLOOPINIT warning
    end
  end

  // Added to resolve SpyGlass W528: Variable 'data' set but not read.
  // This uses 'data' for simulation verification without altering its core functional initialization behavior.
  initial begin
    #1; // Wait a delta cycle for the first initial block to complete
    $display("Initial values of data array:");
    for (int i = 0; i < 4; i++) begin
      $display("  data[%0d] = %h", i, data[i]);
    end
  end
endmodule
