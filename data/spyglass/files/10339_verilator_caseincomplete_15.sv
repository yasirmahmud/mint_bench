module incomplete_case_15;
  reg [0:0] reset_n;
  reg active;
  always @* begin
    case (reset_n)
      1'b1: active = 1'b1;
    endcase
  end
endmodule
