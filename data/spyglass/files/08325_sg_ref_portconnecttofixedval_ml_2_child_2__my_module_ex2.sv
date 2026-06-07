module my_module_ex2 (input in_port);
  // To resolve W240 (Input 'in_port' declared but not read) and
  // WarnAnalyzeBBox (Design Unit 'my_module_ex2' has empty definition),
  // the input port must be read or used within the module.
  // Declaring an internal wire and assigning the input to it uses the input
  // without changing the external functional behavior of the module.
  wire dummy_read_in_port = in_port;
 endmodule
