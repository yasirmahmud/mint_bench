module incomplete_case_13;
  reg [1:0] priority;
  reg grant;
  always @* begin
    case (priority)
      2'b00: grant = 1'b1;
    endcase
  end
endmodule
