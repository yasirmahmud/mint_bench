module curve_w337_20260111_130823_attempt6 (
  input [1:0] sel_in,
  output reg out_data
);

  always @(*) begin
    out_data = 1'b0; // Default assignment to avoid latches

    // W337: Illegal value as case item - Resolved by using 'casex'
    // In a standard 'case' statement, 'x' is not allowed as part of the case item value.
    casex (sel_in) // Changed 'case' to 'casex' to allow 'x' as a don't care in case items
      2'b00: out_data = 1'b0;
      2'b01: out_data = 1'b1;
      2'bx0: out_data = 1'b1;
      2'b11: out_data = 1'b0;
      default: out_data = 1'b0;
    endcasex // Changed 'endcase' to 'endcasex'
  end

endmodule
