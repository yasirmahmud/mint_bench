module my_module_ex2(
  output my_struct_t s_out
);
 typedef struct packed { logic [0:0] a;
 logic [0:0] b;
 } my_struct_t;
 my_struct_t s;
 logic [1:0] vec;

 always_comb begin
  vec = 2'b10;
  s = vec;
  s_out = s; // Added to resolve W528 (set but not read) by making 's' observable
 end

endmodule
