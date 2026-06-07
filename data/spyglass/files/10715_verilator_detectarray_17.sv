module detect_array_17;
  typedef struct { logic [7:0] id; logic [7:0] value; } Entry;
  Entry e1, e2;
  assign e1.id = e2.id;
  assign e2.id = e1.id;
endmodule
