module curve_synth_5142_20260112_003925_689579_w6680_attempt14 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output wire data_out
);

  // Internal register to drive the output, ensuring all inputs are used
  // and avoiding latches in combinational logic.
  reg data_out_reg;

  // Assign the internal register value to the output port.
  assign data_out = data_out_reg;

  // Simple synchronous logic using all declared input ports (clk, rst_n, data_in)
  // to prevent 'unused signal' warnings (e.g., W240).
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out_reg <= 1'b0; // Reset condition uses rst_n
    end else begin
      data_out_reg <= data_in; // Data path uses clk and data_in
    end
  end

  // First specify block: Contains a 'specparam' which is purely for simulation
  // and is ignored by synthesis tools. This triggers the first SYNTH_5142 violation.
  specify
    specparam DELAY_VAL = 7; // A specify parameter, ignored by synthesis.
  endspecify

  // Second specify block: Contains a module path delay, which is also
  // simulation-specific and ignored by synthesis tools. This triggers
  // the second SYNTH_5142 violation.
  specify
    (data_in => data_out) = 2; // Simple module path delay, simulation specific.
  endspecify

endmodule
