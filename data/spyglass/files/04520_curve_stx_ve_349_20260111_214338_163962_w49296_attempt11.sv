module STX_VE_349_test();

  // This final block will execute at the end of simulation.
  // Calling 'exit' without a definition should trigger STX_VE_349.
  final begin
    exit; // STX_VE_349: Task or function name ( exit ) not defined
  end

endmodule
