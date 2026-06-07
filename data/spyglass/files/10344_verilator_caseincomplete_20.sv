module incomplete_case_20;
  reg [3:0] instruction;
  reg [7:0] operand;
  always @* begin
    case (instruction)
      4'h1: operand = 8'h01;
      4'h2: operand = 8'h02;
      4'h3: operand = 8'h03;
      4'h4: operand = 8'h04;
      4'h5: operand = 8'h05;
      4'h6: operand = 8'h06;
      4'h7: operand = 8'h07;
      4'h8: operand = 8'h08;
      4'h9: operand = 8'h09;
      4'hA: operand = 8'h0A;
      4'hB: operand = 8'h0B;
      4'hC: operand = 8'h0C;
      4'hD: operand = 8'h0D;
      4'hE: operand = 8'h0E;
      4'hF: operand = 8'h0F;
    endcase
  end
endmodule
