module top9;
  int data[0:3];

  // synthesis translate_off
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] = i; // Fix: Changed to blocking assignment to resolve Verilator BLKLOOPINIT
    end
    $display("INFO: Initialized data: %p", data); // Fix: Added to resolve SpyGlass W528 (variable set but not read)
  end
  // synthesis translate_on

endmodule
