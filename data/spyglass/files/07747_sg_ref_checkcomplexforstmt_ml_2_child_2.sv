module complex_for_ex2;
 typedef struct packed { reg [49:0][31:0] data;
 reg [7:0] status;
 } my_struct_t;
 reg [7:0] out_reg;
 my_struct_t temp_struct_var;
 integer i, j, k, l;
 always @(*) begin
   for (i = 0; i < 2; i = i + 1) begin
     for (j = 0; j < 2; j = j + 1) begin
       for (k = 0; k < 2; k = k + 1) begin
         for (l = 0; l < 2; l = l + 1) begin
           temp_struct_var.data[l] = i + j + k + l;
         end
         // To resolve SpyGlass W415a: "Signal out_reg is being assigned multiple times
         // (assignment within same for-loop) in same always block",
         // out_reg and temp_struct_var.status assignments are moved outside
         // the innermost 'l' loop. In combinatorial logic with loops, the final
         // value of a signal is determined by its last assignment. Thus, out_reg
         // and temp_struct_var.status effectively take the value from the last
         // iteration of 'l' (when l=1). By assigning them here, they are assigned
         // once per 'k' loop iteration, not multiple times within the 'l' loop.
         out_reg = temp_struct_var.data[1][7:0]; // Value from the last iteration of 'l' (l=1)
         temp_struct_var.status = out_reg;
       end
     end
   end
 end
 endmodule
