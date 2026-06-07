module star_c02_2_1_6_3_ex2(input [1:0] sel, input data_in, output reg data_out);
 reg [7:0] my_array [0:4];
 always @(*) begin
   // Fix for STARC02-2.1.6.3: Latch inferred for 'my_array[0][0]'.
   // `my_array[0]` is read (`data_out = my_array[0]`) but never written by `my_array[sel + 1]`,
   // as `sel + 1` will always evaluate to an index from 1 to 4.
   // Assigning a default value to `my_array[0]` ensures it is always defined,
   // preventing latch inference while preserving the specified writes to other elements.
   my_array[0] = 8'h0; // Assign a known default value to avoid latch

   // Preserve original assignment logic for other elements
   my_array[sel + 1] = data_in; // Verilog will zero-extend 1-bit data_in to 8 bits for my_array element

   // Preserve original output assignment
   data_out = my_array[0];
 end
endmodule
