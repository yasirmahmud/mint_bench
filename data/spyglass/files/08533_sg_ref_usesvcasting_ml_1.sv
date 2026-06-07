module my_module_ex1;
 typedef struct packed { reg [7:0] a;
 reg [7:0] b;
 } my_struct_t;
 my_struct_t s;
 reg [15:0] vec;
 initial begin s = vec;
 end endmodule
