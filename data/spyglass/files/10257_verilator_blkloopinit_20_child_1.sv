module top20;
  logic [7:0] data[0:3];
  initial begin
    int i = 0;
    while (i < 4) begin
      data[i] = 8'h88; // Changed to blocking assignment to resolve BLKLOOPINIT warning
      i++;
    end
    $display("INFO: data initialized: %p", data); // Added a read operation to resolve W528
  end
endmodule
