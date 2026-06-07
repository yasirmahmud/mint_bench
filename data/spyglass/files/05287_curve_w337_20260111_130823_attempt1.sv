module curve_w337 (
  input [1:0] sel,
  output reg out_val
);

  always @(*) begin
    case (sel)
      2'b00: out_val = 1'b0;
      2'b01: out_val = 1'b1;
      2'b1x: out_val = 1'b0; // W337: Illegal value 'x' as case item in 'case' statement
      default: out_val = 1'b0;
    endcase
  end

endmodule
