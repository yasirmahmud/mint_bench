module curve_stx_ve_349_20260111_235629_069101_w37744_attempt16 (
  input wire clk,
  input wire rst_n,
  input wire enable_proc,
  output reg out_val
);

  reg [3:0] counter;

  // Procedural block that calls the undefined 'exit'
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 4'd0;
      out_val <= 1'b0;
    end else begin
      if (enable_proc) begin
        // Increment counter as part of the logic to make the example distinct
        counter <= counter + 1'b1;
        // STX_VE_349 violation: Task or function name ( exit ) not defined
        // The 'exit' identifier is used as an undefined task here.
        exit; 
      end else begin
        out_val <= 1'b1; // Ensure out_val is always assigned to avoid latch/X propagation warnings
      end
    end
  end

  // Dummy always block to ensure 'counter' is read and avoid unused signal warnings.
  // This block does not affect the 'exit' call or infer any latches for 'counter'.
  always @* begin
    if (counter > 4'd7) begin
      // Just a read operation on 'counter'
      // No assignment to 'counter' in this block, so no latch inference.
    end
  end

endmodule
