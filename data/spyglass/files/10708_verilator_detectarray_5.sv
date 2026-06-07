module detect_array_05;
  typedef struct { logic [7:0] val; } simple_struct;
  simple_struct s1, s2;
  assign s1 = s2;
  assign s2 = s1;
endmodule
