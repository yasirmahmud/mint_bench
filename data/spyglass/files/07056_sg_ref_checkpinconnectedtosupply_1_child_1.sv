module top_ex1;
 wire in1, in2;
 wire out_and; // Declare a wire for the AND gate's output
 assign in1 = 1'b0;
 assign in2 = 1'b1;
 and u_and (out_and, in1, in2); // Connect the AND gate output to a wire
 endmodule
