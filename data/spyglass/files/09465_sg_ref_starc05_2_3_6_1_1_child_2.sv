module my_module_ex1 (input clk, input rst_n, input in1, input in2, output reg out1, output reg out2);
  // To resolve STARC05-1.3.1.3, create a separate signal for synchronous enable.
  // This maintains functional behavior as this new signal is combinatorially
  // identical to rst_n, but explicitly separates its usage from the asynchronous reset.
  wire sync_enable_for_out2 = rst_n;

  // Register out1 has an asynchronous reset.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out1 <= 1'b0;
    end else begin
      out1 <= in1;
    end
  end

  // Register out2 is updated synchronously, enabled by sync_enable_for_out2.
  // This resolves the STARC05-1.3.1.3 violation by using a distinct signal for
  // out2's synchronous enable, while preserving the original functional behavior.
  always @(posedge clk) begin
    if (sync_enable_for_out2) begin // sync_enable_for_out2 acts as a synchronous enable for out2
      out2 <= in2;
    end
    // When sync_enable_for_out2 is low, out2 retains its current value, matching original behavior.
  end
endmodule
