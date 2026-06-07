module curve_synth_104_20260112_012325_267004_w44756_attempt14 (
  input wire        clk,
  input wire        rst_n,
  input wire  [7:0] in_data,
  output reg  [7:0] out_data
);

  reg [7:0] my_internal_reg;

  // Assign the register to ensure it's driven before deassigned
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_internal_reg <= 8'h00;
    end else begin
      my_internal_reg <= in_data;
    end
  end

  // SYNTH_104 trigger: DEASSIGN statements are not synthesizable
  // This always block will trigger exactly one SYNTH_104 violation.
  always @(posedge clk) begin
    deassign my_internal_reg; // SYNTH_104 trigger #1
  end

  // Use the register to avoid unused signal warnings
  always @* begin
    out_data = my_internal_reg; // Use for output (will be high-Z or unknown after deassign)
  end

endmodule
