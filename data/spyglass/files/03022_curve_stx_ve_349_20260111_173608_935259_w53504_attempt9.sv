module curve_stx_ve_349_20260111_173608_935259_w53504_attempt9 (
  input wire clk,
  input wire reset_n,
  input wire enable,
  output reg out_val
);

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      out_val <= 1'b0;
    end else if (enable) begin
      // STX_VE_349 violation: Calling 'exit' as an undefined task/function.
      exit; 
      out_val <= 1'b1;
    end else begin
      out_val <= 1'b0;
    end
  end

endmodule
