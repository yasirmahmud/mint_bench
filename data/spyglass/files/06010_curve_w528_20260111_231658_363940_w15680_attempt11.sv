module curve_w528_20260111_231658_363940_w15680_attempt11 (
  input wire clk,
  input wire rst_n,
  input wire [15:0] data_in,
  output reg [15:0] data_out
);

  // This register will be assigned (set) but never read, triggering the W528 violation.
  reg [15:0] internal_buffer_w528;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 16'h0000; // Reset output
      // 'internal_buffer_w528' is set during reset.
      internal_buffer_w528 <= 16'hAAAA; 
    end else begin
      data_out <= data_in; // Ensure data_in is used and data_out is driven
      // 'internal_buffer_w528' is also set during normal operation.
      // Since it's never used in any expression or assigned to another signal/output,
      // it will trigger W528.
      internal_buffer_w528 <= data_in + 16'd1; 
    end
  end

endmodule
