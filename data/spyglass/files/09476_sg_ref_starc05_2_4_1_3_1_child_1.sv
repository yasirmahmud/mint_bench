module star_c05_2_4_1_3_ex1 (input d, input en, input arst, output reg q);
 always @(*) begin
   if (arst)
     q = 1'b0;
   else if (en)
     q = d;
   else
     q = q; // Explicitly preserve the current value when neither reset nor enable is active, making the latch explicit.
 end
endmodule
