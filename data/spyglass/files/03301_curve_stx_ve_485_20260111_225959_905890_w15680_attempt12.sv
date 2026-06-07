module stx_ve_485_example_12 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // STX_VE_485 violation: This `include file 'unfound_params_12.v' is intentionally missing
  // to trigger the rule, as it cannot be found or opened in read mode.
  `include "unfound_params_12.v"

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'd0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
