module curve_w337_20260111_130823_attempt3 (
  input sel_in,
  output reg out_data
);

  always @(*) begin
    out_data = 1'b0; // Default assignment to avoid latches
    casez (sel_in)
      1'b0: out_data = 1'b0;
      1'bx: out_data = 1'b1; // W337: Illegal value 'x' as case item in casez statement
      default: out_data = 1'b0;
    endcase
  end

endmodule
