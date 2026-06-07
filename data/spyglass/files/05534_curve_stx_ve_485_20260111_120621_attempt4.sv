module curve_stx_ve_485_20260111_120621_attempt4 (
  input wire clk,
  input wire rst_n,
  input wire [3:0] in_data,
  output reg [3:0] out_data
);

  // STX_VE_485: This `include directive references a file that does not exist.
  // SpyGlass will report that the include file could not be found or opened.
  `include "project_globals.v" // This file will not be found

  // Simple logic to use the inputs and drive the output, preventing other violations.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 4'd0;
    end else begin
      out_data <= in_data;
    end
  end

endmodule
