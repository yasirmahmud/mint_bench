module example_5;
  logic [15:0] result;
  always @* begin
    result = 16'hAAAA;
    // No reads from any declared variable
  end
endmodule
