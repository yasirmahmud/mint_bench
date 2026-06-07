module curve_stx_ve_485_20260111_120621_attempt1 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // STX_VE_485: This `include directive references a file that does not exist.
  // This will cause SpyGlass to report that the include file could not be found or opened.
  `include "non_existent_file_for_stx_ve_485.v"

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'd0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
