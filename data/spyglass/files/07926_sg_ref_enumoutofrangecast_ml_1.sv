module EnumOutOfRangeCast_ex1;
 typedef enum {RED, GREEN, BLUE} color_t;
 color_t my_color;
 initial begin my_color = color_t'(3);
 end endmodule
