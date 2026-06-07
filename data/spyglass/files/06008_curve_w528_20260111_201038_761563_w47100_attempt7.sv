module curve_w528_20260111_201038_761563_w47100_attempt7 (
  input wire clk,
  input wire rst_n, // Active low reset
  input wire [7:0] data_in,
  output reg [7:0] data_out // Output as reg for synchronous logic
);

  // This wire is assigned a value but never read, triggering W528.
  wire [15:0] internal_flag;

  // Assignment to the unused wire; it is 'set' here.
  // This matches the 15:0 width mentioned in the rule description example.
  assign internal_flag = {data_in, data_in};

  // Simple synchronous logic to use other inputs and outputs correctly
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Active low reset
      data_out <= 8'h00;
    end else begin
      data_out <= data_in; // Use data_in, update data_out synchronously
    end
  end

  // All other signals (clk, rst_n, data_in, data_out) are used.
  // 'internal_flag' is assigned but never read, causing the W528 violation.

endmodule
