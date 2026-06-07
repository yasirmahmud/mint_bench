module enum_range_ex1;
 typedef enum { A, B } my_enum_t;
 my_enum_t state;
 logic out;
 assign out = state[0];
 endmodule
