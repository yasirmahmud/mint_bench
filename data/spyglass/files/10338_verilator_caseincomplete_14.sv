module incomplete_case_14;
  reg [2:0] request;
  reg acknowledge;
  always @* begin
    case (request)
      3'b001: acknowledge = 1'b1;
      3'b010: acknowledge = 1'b1;
      3'b100: acknowledge = 1'b1;
    endcase
  end
endmodule
