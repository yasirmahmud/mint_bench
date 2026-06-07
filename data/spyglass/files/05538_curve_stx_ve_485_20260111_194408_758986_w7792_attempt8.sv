module curve_stx_ve_485_20260111_194408_758986_w7792_attempt8 (
  input wire clk,
  input wire rst_n,
  input wire [3:0] in_val,
  output reg [3:0] out_val
);

  // STX_VE_485 violation: This include file 'config_params.v' will not be found.
  `include "config_params.v"

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_val <= 4'h0;
    end else begin
      out_val <= in_val + 1;
    end
  end

endmodule
