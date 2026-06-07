module curve_stx_ve_1360_20260111_041616_attempt5 (
  input wire clk,
  input wire reset,
  output reg [7:0] out_signal
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // STX_VE_1360: Invalid base ( 0 ) used in based number
      // In Verilog-2001, a based number literal must specify a valid base character
      // ('b', 'd', 'h', 'o') immediately following the apostrophe.
      // The literal 1'0 attempts to use '0' as a base specifier, which is invalid.
      out_signal <= 1'0; // Triggers STX_VE_1360
    end else begin
      out_signal <= 8'h00;
    end
  end

endmodule
