module incomplete_case_7;
  reg [0:0] control_bit;
  reg output_val;
  always @* begin
    case (control_bit)
      1'b1: output_val = 1'b1;
    endcase
  end
endmodule
