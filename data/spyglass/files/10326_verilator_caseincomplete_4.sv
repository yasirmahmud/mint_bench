module incomplete_case_4;
  reg [3:0] opcode;
  reg [7:0] data_out;
  always @* begin
    case (opcode)
      4'h0: data_out = 8'hAA;
      4'h1: data_out = 8'hBB;
      4'h2: data_out = 8'hCC;
      4'h3: data_out = 8'hDD;
    endcase
  end
endmodule
