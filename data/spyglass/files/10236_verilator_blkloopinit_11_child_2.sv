module top11;
  shortint data[0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] = i; // Changed from non-blocking '<=' to blocking '=' to resolve Verilator BLKLOOPINIT warning
    end
    // Read all elements of 'data' to suppress SpyGlass W528 (Variable set but not read).
    // The original void cast caused a syntax error (STX_VE_481) in SpyGlass.
    // Replaced with an 'if (1'b0)' dummy read block for broader tool compatibility, preserving functional behavior.
    if (1'b0) begin
      shortint dummy_val;
      dummy_val = data[0];
      dummy_val = data[1];
      dummy_val = data[2];
      dummy_val = data[3];
    end
  end
endmodule
