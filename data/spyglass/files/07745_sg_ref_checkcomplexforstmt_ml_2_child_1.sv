module complex_for_ex2;
 typedef struct packed { reg [49:0][31:0] data;
 reg [7:0] status;
 } my_struct_t;
 reg [7:0] out_reg;
 my_struct_t temp_struct_var;
 integer i, j, k, l;
 always @(*) begin for (i = 0; i < 2; i = i + 1) begin for (j = 0; j < 2; j = j + 1) begin for (k = 0; k < 2; k = k + 1) begin for (l = 0; l < 2; l = l + 1) begin temp_struct_var.data[l] = i + j + k + l;
 out_reg = temp_struct_var.data[l][7:0];
 temp_struct_var.status = out_reg;
 end end end end end endmodule
