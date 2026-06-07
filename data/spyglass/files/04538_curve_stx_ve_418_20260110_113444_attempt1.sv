module curve_stx_ve_418_20260110_113444_attempt1 (
  input wire clk,
  input wire rst_n,
  output reg out_reg
);

  // Minimal logic to ensure all inputs/outputs are used and avoid unused signal warnings
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= ~out_reg;
    end
  end

  // The 'clk' signal is an input port and not driven by a gate output within this module.
  // Using it as a path startpoint in a specify block triggers STX_VE_418.
  specify
    (clk => out_reg) = (1, 2); // Example path delay
  endspecify

endmodule
