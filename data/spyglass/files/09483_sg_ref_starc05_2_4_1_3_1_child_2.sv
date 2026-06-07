module star_c05_2_4_1_3_ex1 (input d, input en, input arst, output reg q);
 always @(d or en or arst) begin
   if (arst)
     q = 1'b0;
   else if (en)
     q = d;
   // Implicitly preserve the current value when neither reset nor enable is active, inferring a latch.
 end
endmodule
