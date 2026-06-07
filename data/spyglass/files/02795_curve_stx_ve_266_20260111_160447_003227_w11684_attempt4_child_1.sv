module curve_stx_ve_266_20260111_160447_003227_w11684_attempt4 (
  input wire clk,
  input wire rst,
  output reg out_data
);

  // Minimal RTL to prevent 'unused signal' or 'undriven output' warnings/violations
  // that could trigger other SpyGlass rules, ensuring only STX_VE_266 is reported.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      out_data <= 1'b0;
    end else begin
      out_data <= clk; // Simple assignment to prevent unused warnings
    end
  end

endmodule
