module SUB_MOD (
  input in_port,
  output out_port
);
  parameter PARAM_VAL = 1; // Default integer parameter
  
  // Trivial logic to ensure ports are used and avoid unused signal warnings
  assign out_port = in_port;
  
endmodule
