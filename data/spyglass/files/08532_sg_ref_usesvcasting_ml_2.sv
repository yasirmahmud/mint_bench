module my_module_ex2;
 typedef struct packed { logic [0:0] a;
 logic [0:0] b;
 } my_struct_t;
 my_struct_t s;
 logic [1:0] vec;
 always_comb begin vec = 2'b10;
 s = vec;
 end endmodule
