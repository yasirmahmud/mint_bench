module differ_always_ml_ex1 (
  input input_a,
  input input_b,
  output reg data
);

// Original behavior was undefined due to mixed blocking and non-blocking
// assignments to 'data' and multiple assignments within the same always block.
// To resolve SYNTH_77, W505, W415a, 'data' is now assigned once with a blocking assignment,
// inferring combinational logic, which is typical for an 'always @*' block.
// We choose input_b as the source for data to provide a concrete, working example.
// Making input_a, input_b, and data ports resolves W123 and W528.
always @* begin
  data = input_b;
end

endmodule
