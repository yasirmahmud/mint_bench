module detect_array_09;
  typedef struct packed { logic [3:0] x; } small_struct_t;
  small_struct_t s_array [0:1];
  assign s_array[0] = s_array[1];
  assign s_array[1] = s_array[0];
endmodule
