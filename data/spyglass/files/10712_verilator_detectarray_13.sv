module detect_array_13;
  typedef struct packed { logic [7:0] x; logic [7:0] y; } Point;
  Point p1, p2;
  assign p1.x = p2.x;
  assign p2.x = p1.x;
endmodule
