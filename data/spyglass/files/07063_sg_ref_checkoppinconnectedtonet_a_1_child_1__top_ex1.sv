module top_ex1 ();
 wire dummy_in;
 wire dummy_out; // Added to connect to the output port
 assign dummy_in = 1'b0; // Added to drive the input port
 my_cell I1 (.in1(dummy_in), .out1(dummy_out)); // Connected output port
 endmodule
