module test18;
  `define CONDITIONAL_ASSIGN (enable) ? \
  data_in : 0
  logic enable, data_in, data_out;

  initial begin
    // Provide values for 'enable' and 'data_in' to resolve undriven errors
    enable = 1'b1;
    data_in = 1'b0;
    #1; // Allow time for assign statement to propagate
    // Read 'data_out' to resolve 'set but not read' warning
    $display("Test: enable=%b, data_in=%b, data_out=%b", enable, data_in, data_out);
  end

  assign data_out = `CONDITIONAL_ASSIGN;
endmodule
