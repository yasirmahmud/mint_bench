module example_7;
  output reg [0:0] enable;
  always @* begin
    enable = 1'b0;
    // Empty sensitivity list inferred
  end
endmodule
