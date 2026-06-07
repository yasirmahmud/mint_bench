module detect_array_03;
  typedef struct packed { logic [7:0] data; } item_t;
  item_t items [0:1];
  assign items[0] = items[1];
  assign items[1] = items[0];
endmodule
