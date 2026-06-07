module Project2 #(parameter WIDTH = 8) (
	input reset_n, clock, capture,
    input [1:0] op,
  	input [WIDTH-1:0] d_in,
    output valid,
  	output [WIDTH:0] result
);

  //4 capture wires from the controller
  wire cap1, cap2, cap3, cap4;
  
  //instance of datapath
  datapath dp1(.reset_n(reset_n), .clock(clock), .capture(capture), .op(op), .d_in(d_in),.cap1(cap1), .cap2(cap2), .cap3(cap3), .cap4(cap4), .result(result));
  
  //instance of controller
  controller con1(.capture(capture), .clock(clock), .reset_n(reset_n), .op(op), .cap1(cap1), .cap2(cap2), .cap3(cap3), .cap4(cap4), .valid(valid));
  
endmodule
