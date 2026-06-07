module enum_out_of_range_cast_ex2;
 typedef enum {RED, GREEN, BLUE} color_t;
 color_t my_color;
 initial begin my_color = color_t'(5);
 end endmodule
