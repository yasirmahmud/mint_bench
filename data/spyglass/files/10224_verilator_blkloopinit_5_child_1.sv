module top5;
  typedef enum { RED, GREEN, BLUE } color_t;
  color_t colors[0:3];
  initial begin
    for (int i = 0; i < 4; i++) begin
      colors[i] = BLUE;
    end
  end
endmodule
