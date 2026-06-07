module curve_stx_ve_488_20260110_115633_attempt5;
  // This example targets STX_VE_488 by using single quotes instead of double quotes
  // for the include directive's file path. This is distinct from previous attempts
  // which used backticks, and should directly trigger the "Missing \" in include directive" rule.
  `include 'path/to/my_header.vh'

  // Minimal valid RTL to avoid other unrelated violations
  input wire clk;
  input wire rst_n;
  output reg [7:0] counter;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 8'h00;
    end else begin
      counter <= counter + 8'h01;
    end
  end

endmodule
