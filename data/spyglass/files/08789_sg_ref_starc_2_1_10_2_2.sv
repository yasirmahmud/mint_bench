module my_module_ex2 (input wire clk);
 typedef struct { reg a;
 reg b;
 } my_rec_t;
 my_rec_t my_rec_var;
 always @(posedge clk) my_rec_var.a <= my_rec_var.b;
 endmodule
