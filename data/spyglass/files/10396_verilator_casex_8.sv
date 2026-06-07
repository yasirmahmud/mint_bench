module casex_example_08(
  input [3:0] control_sig,
  output reg [1:0] status
);
  always @* begin
    casex (control_sig)
      4'b0xx0: status = 2'b00;
      4'b1xx1: status = 2'b01;
      4'b0x1x: status = 2'b10;
      default: status = 2'b11;
    endcase
  end
endmodule
