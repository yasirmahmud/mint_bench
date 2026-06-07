module FREQUENCY_ADJUSTER #(
  parameter integer DIVISOR = 10
) (
  input wire clk_in,
  output wire out_pulse
);
  reg [3:0] counter; // Counter for division, minimal width for small divisors

  always @(posedge clk_in) begin
    if (counter == DIVISOR - 1) begin
      counter <= 0;
    end else begin
      counter <= counter + 1;
    end
  end

  // Drive the output based on the counter state to ensure 'out_pulse' is used.
  assign out_pulse = (counter == 0);
endmodule
