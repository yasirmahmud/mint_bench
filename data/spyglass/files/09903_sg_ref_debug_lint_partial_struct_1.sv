module partial_struct_ex1;
 typedef struct { logic a;
 logic b;
 } my_struct_t;
 my_struct_t s_var;
 initial begin s_var.a = 1'b1;
 end logic read_a;
 assign read_a = s_var.a;
 endmodule
