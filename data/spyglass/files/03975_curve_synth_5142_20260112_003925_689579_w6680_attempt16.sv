module curve_synth_5142_20260112_003925_689579_w6680_attempt16 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output wire data_out
);

  reg data_out_reg; // Internal register to hold data for output

  // Connect internal register to output port
  assign data_out = data_out_reg;

  // Simple synchronous logic to use all inputs and avoid other violations
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out_reg <= 1'b0; // Reset condition
    end else begin
      data_out_reg <= data_in; // Data path
    end
  end

  // This specify block contains a specparam, which is purely for simulation
  // and is ignored by synthesis tools. This triggers a SYNTH_5142 violation.
  specify
    specparam SETUP_MARGIN = 2.5; // A specify parameter for simulation.
  endspecify

endmodule
