module incomplete_case_3;
  reg [0:0] flag;
  reg result;
  always @* begin
    case (flag)
      1'b0: result = 1'b0;
    endcase
  end
endmodule
