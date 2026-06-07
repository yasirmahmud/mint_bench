module example_08;
  reg k;
  initial begin
    k <= 1'b1; // Removed explicit time delay '#30' to resolve ASSIGNDLY warning and CheckDelayTimescale-ML violation.
  end
endmodule
