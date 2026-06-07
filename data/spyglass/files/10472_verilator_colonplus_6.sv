module test6;
  parameter WIDTH = 8;
  logic [(2*WIDTH)-1:0] full_word;
  logic [WIDTH-1:0] half_word;
  assign half_word = full_word[WIDTH :+ WIDTH];
endmodule
