module top3;
  logic [7:0] data[0:3][0:3];

  initial begin
    // Initialize the unpacked array using nested loops and blocking assignments,
    // as suggested by the Verilator BLKLOOPINIT resolution guidance.
    for (int i = 0; i < 4; i++) begin
      for (int j = 0; j < 4; j++) begin
        data[i][j] = 8'hCC; // Using blocking assignment to avoid BLKLOOPINIT if in a complex loop
      end
    end
    
    // Add a read to 'data' to resolve SpyGlass W528 (variable set but not read).
    // An assertion provides a useful check while consuming the variable.
    assert (data[0][0] == 8'hCC) else $error("Data initialization check failed!");
  end
endmodule
