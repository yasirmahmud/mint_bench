module curve_w528_20260111_201038_761563_w47100_attempt6 (
  input wire clk,
  input wire rst,
  input wire [7:0] data_in
);

  // This register is assigned but never read, triggering W528.
  reg [7:0] internal_status_reg;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      internal_status_reg <= 8'h00;
    end else begin
      internal_status_reg <= data_in; // Assigned here
    end
  end

  // No other logic reads or uses internal_status_reg.

endmodule
