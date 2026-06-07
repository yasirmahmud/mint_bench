module top12 (
  output longint data[0:3]
);
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] = i; // Changed to blocking assignment to resolve Verilator BLKLOOPINIT
    end
  end
endmodule
