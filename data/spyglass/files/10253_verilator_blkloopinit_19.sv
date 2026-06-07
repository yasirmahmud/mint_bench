module top19;
  typedef struct { logic [7:0] val; } my_struct_t;
  my_struct_t data[0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i].val <= 8'h77;
    end
  end
endmodule
