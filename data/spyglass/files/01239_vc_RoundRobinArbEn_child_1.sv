module vc_RoundRobinArbEn #( parameter p_num_reqs = 2 )
(
  input                  clk,
  input                  reset,
  input                  en,        // 1 = update priorities
  input  [p_num_reqs-1:0] reqs,    // 1 = making a req, 0 = no req
  output [p_num_reqs-1:0] grants   // (one-hot) 1 is req won grant
);

  // We only update the priority if a requester actually received a grant

  wire priority_en;
  assign priority_en = |grants && en;

  // Next priority is just the one-hot grant vector left rotated by one

  wire [p_num_reqs-1:0] priority_next;
  assign priority_next = { grants[p_num_reqs-2:0], grants[p_num_reqs-1] };

  // State for the one-hot priority vector

  wire [p_num_reqs-1:0] priority_;

  vc_EnResetReg#(p_num_reqs,1) priority_reg
  (
    .clk   (clk),
    .reset (reset),
    .en    (priority_en),
    .d     (priority_next),
    .q     (priority_)
  );

  // Variable arbiter chain

  wire dummy_kout;

  vc_VariableArbChain#(p_num_reqs) variable_arb_chain
  (
    .kin       (1'b0),
    .priority_ (priority_),
    .reqs      (reqs),
    .grants    (grants),
    .kout      (dummy_kout)
  );

endmodule
