module curve_synth_104_20260112_012325_267004_w44756_attempt15 (
  input wire        clk,
  input wire  [3:0] data_in,
  output reg  [3:0] data_out
);

  reg [3:0] data_reg;

  // Assign a value to data_reg to ensure it is driven procedurally.
  always @(posedge clk) begin
    data_reg <= data_in;
  end

  // SYNTH_104 trigger: DEASSIGN statements are not synthesizable.
  // This 'always @*' block will trigger exactly one SYNTH_104 violation.
  always @* begin
    deassign data_reg; // SYNTH_104 trigger #1
  end

  // Use data_reg to avoid unused signal warnings.
  // After deassign, data_reg's value for synthesis becomes indeterminate or high-Z.
  always @* begin
    data_out = data_reg;
  end

endmodule
