module curve_stx_ve_462_20260111_034555_attempt2 (
  input wire clk,
  input wire rst,
  input wire [3:0] a,
  input wire [3:0] b,
  output wire [7:0] my_vector [0:2] // Unpacked array
);

  // STX_VE_462: Illegal assignment, expecting assignment pattern.
  // This rule is triggered because a replication of a packed concatenation
  // ({a,b} forms an 8-bit packed vector, and {3{a,b}} is a 24-bit packed vector)
  // is directly assigned to an unpacked array ('my_vector' is 3 elements of 8-bit each)
  // in Verilog-2001. SystemVerilog requires an assignment pattern for this syntax.
  // Fixed by assigning each element of the unpacked array individually.
  assign my_vector[0] = {a, b};
  assign my_vector[1] = {a, b};
  assign my_vector[2] = {a, b};

  // Dummy logic to prevent unused signal warnings for clk and rst
  wire dummy_net;
  assign dummy_net = clk | rst;

endmodule
