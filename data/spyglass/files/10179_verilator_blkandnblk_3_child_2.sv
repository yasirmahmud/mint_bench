module ex3;
  reg [1:0] c;
  output [1:0] out_c; // Added to resolve W528

  assign out_c = c; // 'c' is now read and connected to an output

  always @* begin
    c = 2'b10;
  end
endmodule
