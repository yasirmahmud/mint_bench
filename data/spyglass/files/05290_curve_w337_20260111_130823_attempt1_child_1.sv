module curve_w337 (
  input [1:0] sel,
  output reg out_val
);

  always @(*) begin
    casex (sel) // Changed from 'case' to 'casex' to correctly handle 'x' as a don't-care
      2'b00: out_val = 1'b0;
      2'b01: out_val = 1'b1;
      2'b1x: out_val = 1'b0;
      default: out_val = 1'b0;
    endcasex // Changed from 'endcase' to 'endcasex'
  end

endmodule
