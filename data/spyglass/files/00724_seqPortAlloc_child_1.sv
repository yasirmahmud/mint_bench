module seqPortAlloc #(
  parameter NUM_PORT = 8 // Define NUM_PORT as a module parameter
) (
  input  [NUM_PORT-1:0] availPortVector_in,
  input  [NUM_PORT-1:0] ppv,
  output [NUM_PORT-1:0] allocatedPortVector,
  output [NUM_PORT-1:0] availPortVector_out
);

  // Wires for intermediate signals, now using the defined parameter NUM_PORT
	wire [NUM_PORT-1:0] desiredPort;
	wire [NUM_PORT-1:0] deflectedPort;
	
  // Instantiate firstOne modules, passing NUM_PORT as a parameter
  // Assuming firstOne takes the input vector as the first argument and output vector as the second
  firstOne #(NUM_PORT) port_alloc_desired (ppv & availPortVector_in, desiredPort);	
  firstOne #(NUM_PORT) port_alloc_deflect (availPortVector_in, deflectedPort);	
	
	// Logic for allocation and available ports
	assign allocatedPortVector = |desiredPort ? desiredPort : deflectedPort;
  assign availPortVector_out = availPortVector_in & ~allocatedPortVector;
 
endmodule
