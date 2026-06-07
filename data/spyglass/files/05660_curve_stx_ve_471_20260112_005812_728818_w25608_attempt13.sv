module curve_stx_ve_471_20260112_005812_728818_w25608_attempt13 (
  input clk,
  input rst,
  output reg [7:0] data_out
);

  reg [7:0] internal_data;

  // STX_VE_471: The 'reg' keyword immediately after 'translate_on' on the same line
  // constitutes a syntax error. The pragma expects to end after 'translate_on'.
  // synopsys translate_on reg [7:0] illegal_declaration;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      internal_data <= 8'h00;
    end else begin
      internal_data <= 8'hFF;
    end
  end

  assign data_out = internal_data;

endmodule
