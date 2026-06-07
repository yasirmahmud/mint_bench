module incomplete_case_no_default_1 (
  input [1:0] sel,
  output reg out
);

  always @* begin
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      // Missing 2'b10 and 2'b11, and no default
    endcase
  end

endmodule
