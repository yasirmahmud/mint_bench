module star_c05_2_1_6_3_ex2 (input [1:0] sel, output out);
 reg data_array [0:4];

 initial begin
   // Initialize all elements of data_array to 0 to prevent uninitialized states
   for (int i = 0; i < 5; i = i + 1) begin
     data_array[i] = 1'b0;
   end
 end

 assign out = data_array[sel + 1];
 endmodule
