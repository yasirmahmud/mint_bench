module curve_synth_1084_attempt6 (
  input wire clk,
  output reg out_reg
);

  // SYNTH_1084 violation: parameter cannot be assigned a timeliteral value
  parameter PROPAGATION_DELAY = 200ps; // This line triggers SYNTH_1084

  always @(posedge clk) begin
    // Minimal logic to use output and avoid latches or unused warnings
    out_reg <= ~out_reg;
  end

endmodule
