module test5;
  logic [63:0] long_vec;
  logic [15:0] temp_vec;
  always @* begin
    temp_vec = long_vec[32 :+ 16];
  end
endmodule
