module incomplete_case_6;
  reg [2:0] command;
  reg [15:0] value;
  always @* begin
    case (command)
      3'b001: value = 16'h1234;
      3'b010: value = 16'h5678;
      3'b100: value = 16'hABCD;
    endcase
  end
endmodule
