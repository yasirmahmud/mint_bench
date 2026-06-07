module curve_w337_20260111_130823_attempt2 (
  input [2:0] sel_in,
  output reg out_data
);

  always @(*) begin
    out_data = 1'b0; // Default assignment to avoid latches
    case (sel_in)
      3'b000: out_data = 1'b0;
      3'b001: out_data = 1'b1;
      3'b010: out_data = 1'b0;
      3'b1zz: out_data = 1'b1; // W337: Illegal value 'z' as case item in a standard 'case' statement
      default: out_data = 1'b0;
    endcase
  end

endmodule
