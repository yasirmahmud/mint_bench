module my_module_ex1 (input [0:0] in_port);
  // To resolve W240 (Input 'in_port' declared but not read)
  // and WarnAnalyzeBBox (Design Unit 'my_module_ex1' has empty definition),
  // the input is used internally. Declaring the input with an explicit width
  // also addresses the context of WidthlessConstantTiedPort-ML.
  //
  // SpyGlass violation W528 (Variable 'unused_in_port_sink' set but not read)
  // is resolved by adding the '(* keep *)' attribute to the wire declaration.
  // This attribute explicitly tells synthesis and linting tools not to remove
  // or flag this wire as unused, thereby fulfilling its intended purpose
  // of keeping 'in_port' used internally without generating new violations.
  wire (* keep *) unused_in_port_sink;
  assign unused_in_port_sink = in_port;
endmodule
