module curve_badimplicitsm2_20260111_010524_attempt4 (
  input wire data_in,
  input wire clk_i,
  output reg state_q,
  output reg state_qn
);

  // This always block attempts to update two different registers
  // on different clock phases (posedge and negedge) of the same clock
  // within a single always block. This implicitly forms an unsynthesizable
  // state machine where states are updated on different clock edges,
  // which is a violation of badimplicitSM2. This design attempts
  // to make the example distinct from previous attempts by using 1-bit signals
  // and different logic for the negedge-triggered register.
  always begin
    @(posedge clk_i) state_q <= data_in;
    @(negedge clk_i) state_qn <= ~data_in;
  end

endmodule
