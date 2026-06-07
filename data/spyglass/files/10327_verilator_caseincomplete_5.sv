module incomplete_case_5;
  reg [1:0] mode;
  reg enable;
  always @* begin
    case (mode)
      2'd0: enable = 1'b0;
      2'd1: enable = 1'b1;
      2'd2: enable = 1'b0;
    endcase
  end
endmodule
