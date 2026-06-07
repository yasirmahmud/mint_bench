module weak_assertion_example1 (
  input clk,
  input rst_n,
  input a,
  input b
);

`ifndef SYNTHESIS
  property p_a_implies_b_weak;
    @(posedge clk) disable iff (!rst_n)
    a |=> ##[1:2] b;
  endproperty

  assert property (p_a_implies_b_weak);
`endif

  // Dummy logic to consume inputs for synthesis and prevent W240 warnings.
  // This ensures 'clk', 'rst_n', 'a', and 'b' are used in synthesizable logic.
  reg dummy_r;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      dummy_r <= 1'b0;
    end else begin
      dummy_r <= a ^ b; // Uses 'a' and 'b'
    end
  end

endmodule
