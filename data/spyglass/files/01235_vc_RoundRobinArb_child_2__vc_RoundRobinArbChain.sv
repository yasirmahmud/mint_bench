module vc_RoundRobinArbChain
#(
  parameter p_num_reqs             = 2,
  parameter p_priority_reset_value = 1  // (one-hot) 1 = high priority req
)(
  input  wire                  clk,
  input  wire                  kin,    // kill in
  input  wire                  reset,
  input  wire [p_num_reqs-1:0] reqs,   // 1 = making a req, 0 = no req
  output wire [p_num_reqs-1:0] grants, // (one-hot) 1 is req won grant
  output wire                  kout    // kill out
);

  // We only update the priority if a requester actually received a grant

  wire priority_en;
  assign priority_en = |grants;

  // Next priority is just the one-hot grant vector left rotated by one
  // If grants = G(N-1) ... G(1) G(0)
  // A left rotation by one is G(N-2) ... G(0) G(N-1)
  wire [p_num_reqs-1:0] priority_next;
  assign priority_next = (p_num_reqs > 0) ? { grants[p_num_reqs-2:0], grants[p_num_reqs-1] } : 1'b0;

  // State for the one-hot priority vector

  wire [p_num_reqs-1:0] priority_;

  // Instance of the enabled reset register to store the priority vector
  vc_EnResetReg#(p_num_reqs,p_priority_reset_value) priority_reg
  (
    .clk   (clk),
    .reset (reset),
    .en    (priority_en),
    .d     (priority_next),
    .q     (priority_)
  );

  // Instance of the variable arbiter chain to perform the actual arbitration
  vc_VariableArbChain#(p_num_reqs) variable_arb_chain
  (
    .kin       (kin),
    .priority_ (priority_),
    .reqs      (reqs),
    .grants    (grants),
    .kout      (kout)
  );

endmodule
