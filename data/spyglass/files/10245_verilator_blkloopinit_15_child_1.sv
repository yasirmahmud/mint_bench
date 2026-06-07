module top15;
  logic [7:0] data[0:3];
  initial begin
    automatic int k = 0;
    for (int i = 0; i < 4; i++) begin
      data[i] = 8'h33 + k; // Changed from non-blocking '<=' to blocking '=' to resolve BLKLOOPINIT
      k++;
    end
    // Added a $display statement to "read" the 'data' array and resolve SpyGlass W528 (variable set but not read).
    $display("Initialized data: data[0]=%h, data[1]=%h, data[2]=%h, data[3]=%h",
             data[0], data[1], data[2], data[3]);
  end
endmodule
