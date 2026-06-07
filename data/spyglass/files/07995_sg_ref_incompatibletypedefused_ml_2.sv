typedef struct packed { reg [7:0] a;
 reg [7:0] b;
 } my_struct_type1;
 typedef struct packed { reg [15:0] c;
 } my_struct_type2;
 module incompatible_typedef_ex2;
 my_struct_type1 var1;
 my_struct_type2 var2;
 assign var2 = var1;
 endmodule
