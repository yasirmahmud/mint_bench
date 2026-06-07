module analog_cell_lib (input ana_pin);
  // SpyGlass W240 fix: Dummy read to prevent 'input not read' warning
  wire unused_ana_pin = ana_pin;
  
  // SpyGlass W528 fix: Dummy read to prevent 'variable set but not read' warning
  // This initial block will not be synthesized and the conditional ensures no simulation impact.
  initial begin
    if (1'b0) begin // This branch is never taken
      $display("Dummy read of unused_ana_pin: %b", unused_ana_pin);
    end
  end
endmodule
