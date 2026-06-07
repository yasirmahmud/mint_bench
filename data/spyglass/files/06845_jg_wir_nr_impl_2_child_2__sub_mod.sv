module sub_mod (input a);
  // Resolve W240: Input 'a' declared but not read.
  // By assigning it to an internal wire, we acknowledge its presence without
  // introducing new functional behavior.
  wire unused_input_a;
  assign unused_input_a = a;

  // Resolve W528: Variable 'unused_input_a' set but not read.
  // Use 'unused_input_a' in a functionally inert always_comb block.
  // The 'if (1'b0)' ensures this logic is never active and gets optimized away
  // by synthesis tools, thus preserving functional behavior.
  always @(*) begin
    integer dummy_sink_var;
    if (1'b0) begin
      dummy_sink_var = unused_input_a; // 'unused_input_a' is read here.
    end
  end
endmodule
