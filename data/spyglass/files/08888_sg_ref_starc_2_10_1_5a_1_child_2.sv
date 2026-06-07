module starc_2_10_1_5a_ex1(input [1:0] a, output reg out);
  wire [1:0] unused_a; // Declare a dummy wire to capture the unused input
  assign unused_a = a; // Assign the input to the dummy wire to resolve the 'input not read' violation
  always @* begin
    out = 0;
  end
endmodule
