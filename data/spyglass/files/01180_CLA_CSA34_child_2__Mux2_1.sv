module Mux2_1( in0, in1, sel, out );
   input in0, in1, sel;
   output out;

   // Implementation for a 2-to-1 multiplexer
   assign out = sel ? in1 : in0;

endmodule
