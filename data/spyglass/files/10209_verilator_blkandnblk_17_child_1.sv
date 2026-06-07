`timescale 1ns/1ps
module ex17;
  reg q;
  always @* begin
    q <= 1'b1; // Changed from blocking to non-blocking to resolve BLKANDNBLK violation
    #1 q <= 1'b0;
  end
endmodule
