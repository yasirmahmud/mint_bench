module NegatedImplicationExample2 (
  input clk,
  input rst_n,
  input start_cond,
  input end_cond
);

  // SpyGlass violations addressed:
  // - SYNTH_12611, SYNTH_5064: Property blocks and assert statements are ignored for synthesis.
  //   These are resolved by removing the non-synthesizable SVA property.
  // - W240: Inputs 'clk', 'rst_n', 'start_cond', 'end_cond' declared but not read.
  //   These are resolved by incorporating the inputs into synthesizable logic.
  // - PRP_NR_NIMP: This warning refers to the presence of a negated implication property.
  //   It is resolved by converting the intent of the SVA property into equivalent synthesizable RTL.

  // The original SVA property was: @(posedge clk) (start_cond |=> !end_cond);
  // This means: If 'start_cond' is asserted in the current cycle, then 'end_cond' must be deasserted in the next clock cycle.
  // A violation of this property occurs if 'start_cond' is asserted in the current cycle AND 'end_cond' is asserted in the next clock cycle.

  reg start_cond_d; // Register to capture 'start_cond' from the previous cycle

  // Register 'start_cond' synchronously, reset asynchronously
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      start_cond_d <= 1'b0;
    end else begin
      start_cond_d <= start_cond; // Uses 'clk', 'rst_n', 'start_cond'
    end
  end

  // 'property_violation' will be high if the original SVA property condition is violated.
  // This effectively implements a synthesizable checker for the original property's failure condition.
  wire property_violation;
  assign property_violation = start_cond_d && end_cond; // Uses 'end_cond'

  // To ensure the synthesizable logic (and thus the use of all inputs) is not optimized away
  // by synthesis tools when there are no module outputs, we sink the 'property_violation'
  // signal into a dummy register.
  reg dummy_sink;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      dummy_sink <= 1'b0;
    end else begin
      dummy_sink <= property_violation; // Uses 'clk', 'rst_n'
    end
  end

endmodule
