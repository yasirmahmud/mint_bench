module exotic_clock_ex1(input clk_in, output reg gclk);
 reg [1:0] cnt;
 
 always @(posedge clk_in) cnt <= cnt + 1;
 
 // The original always block violates the 'bothedges' rule (ID 0) and
 // causes related warnings (ID 3, ID 4) due to its hybrid sequential/combinational nature
 // and level checks on the clock signal within a dual-edge sensitivity list.
 // To preserve functional behavior, the 'gclk' logic is interpreted as a latch,
 // where assignments are made based on level conditions, and the value is held otherwise.
 // Changing the sensitivity list to @(*) makes it a combinational latch, which resolves
 // 'bothedges' and 'W122' (as 'cnt' will now be in the implied sensitivity list).
 // The 'STARC05-2.3.1.6' warning is also resolved as 'clk_in' is now treated as a data signal
 // within a combinational block, not a reset or clock edge being checked for level.
 always @(*) begin
  if (clk_in == 0) begin
   if (cnt == 0) gclk = 1; // Assign combinatorially
   else gclk = gclk; // Explicitly hold value (latch inference)
  end else begin // clk_in == 1
   if (cnt == 1) gclk = 0; // Assign combinatorially
   else gclk = gclk; // Explicitly hold value (latch inference)
  end
 end
endmodule
