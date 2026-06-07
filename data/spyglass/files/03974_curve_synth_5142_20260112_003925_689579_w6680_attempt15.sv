module curve_synth_5142_20260112_003925_689579_w6680_attempt15 (
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

  // First specify block: Contains a $setuphold timing check,
  // which is purely for simulation and ignored by synthesis tools.
  // This triggers the first SYNTH_5142 violation.
  specify
    $setuphold(posedge clk, data_in, 5, 2); // $setuphold(reference_event, data_event, setup_limit, hold_limit)
  endspecify

  // Second specify block: Contains a $period timing check,
  // also simulation-specific and ignored by synthesis tools.
  // This triggers the second SYNTH_5142 violation.
  specify
    $period(posedge clk, 10); // $period(reference_event, limit)
  endspecify

endmodule
