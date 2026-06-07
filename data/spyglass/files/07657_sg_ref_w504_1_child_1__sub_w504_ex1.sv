module sub_w504_ex1 (input [7:0] in_port);
  // Fix for W240 (Input declared but not read) and WarnAnalyzeBBox (Empty definition)
  // Capturing the input internally addresses these violations without changing module interface.
  wire [7:0] in_port_internal = in_port;
endmodule
