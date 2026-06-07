module casex_example_16(
  input [2:0] control_bits,
  output reg [1:0] output_state
);
  always @* begin
    casex (control_bits)
      3'b0x1: output_state = 2'b00;
      3'b1x0: output_state = 2'b01;
      3'bxxx: output_state = 2'b10;
    endcase
  end
endmodule
