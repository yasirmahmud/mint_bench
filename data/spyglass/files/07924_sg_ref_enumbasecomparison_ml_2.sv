module EnumBaseComparison_ex2;
 typedef enum {RED, GREEN, BLUE} color_t;
 typedef enum {SMALL, MEDIUM, LARGE} size_t;
 color_t my_color;
 size_t my_size;
 initial begin my_color = RED;
 my_size = SMALL;
 if (my_color == my_size) begin end end endmodule
