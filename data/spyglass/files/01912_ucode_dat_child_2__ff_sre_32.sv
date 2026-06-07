module ff_sre_32 (
  output reg [31:0] out,
  input  [31:0] din,
  input         enable,
  input         reset_l, // Active low reset
  input         clk
);
  always_ff @(posedge clk or negedge reset_l) begin
    if (!reset_l) begin
      out <= 32'b0;
    end else if (enable) begin
      out <= din;
    end
  end
endmodule
