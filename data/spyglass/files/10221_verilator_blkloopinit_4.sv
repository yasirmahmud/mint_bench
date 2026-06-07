module top4;
  typedef struct packed { bit a; bit b; } my_struct_t;
  my_struct_t data[0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      data[i] <= '{a:1, b:0};
    end
  end
endmodule
