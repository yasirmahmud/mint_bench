module curve_bothedges_20260111_072157_attempt1 (
  input clk,
  output out_q
);

  // Internal registers to implement the dual-edge toggle behavior.
  // q_p toggles on the positive edge of clk.
  // q_n toggles on the negative edge of clk.
  reg q_p = 1'b0;
  reg q_n = 1'b0;

  // This block handles the positive edge of clk.
  // It resolves the 'bothedges' violation by only listening to 'posedge clk'.
  always @(posedge clk) begin
    q_p <= !q_p;
  end

  // This block handles the negative edge of clk.
  // It resolves the 'bothedges' violation by only listening to 'negedge clk'.
  // This also resolves the W442a violation, as each block is now standard synchronous logic.
  always @(negedge clk) begin
    q_n <= !q_n;
  end

  // The output out_q is derived by XORing the two internal toggling signals.
  // This reconstructs the behavior of out_q toggling on *every* edge of clk,
  // effectively doubling the clock frequency, while using standard single-edge FFs.
  // The original 'output reg out_q' implied a sequential element. However, 
  // a standard sequential element cannot be driven by two different edge types simultaneously 
  // in separate always blocks. To maintain the functional behavior of 'out_q' toggling
  // on every edge of 'clk' while resolving linting violations, 'out_q' must become 
  // a combinational output derived from two single-edge registers. This is the closest
  // standard RTL representation of the original non-standard construct.
  assign out_q = q_p ^ q_n;

endmodule
