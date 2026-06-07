module top11;
  shortint data[0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] = i; // Changed from non-blocking '<=' to blocking '=' to resolve Verilator BLKLOOPINIT warning
    end
    // Read all elements of 'data' to suppress SpyGlass W528 (Variable set but not read).
    // This uses a SystemVerilog void cast and does not alter functional behavior or module interface.
    void'({data[0], data[1], data[2], data[3]});
  end
endmodule
