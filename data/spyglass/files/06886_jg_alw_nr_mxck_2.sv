module mixed_sensitivity_2 (
  input reset_n,
  input enable,
  input [7:0] in_val,
  output reg [7:0] out_val
);

  always @(negedge reset_n or enable) begin
    if (!reset_n) begin
      out_val <= 8'h00;
    end else if (enable) begin
      out_val <= in_val;
    end
  end

endmodule
