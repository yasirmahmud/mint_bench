module vc_FixedArbChain
#(
  parameter p_num_reqs = 2
)(
  input  logic                  kin,    // kill in
  input  logic [p_num_reqs-1:0] reqs,   // 1 = making a req, 0 = no req
  output logic [p_num_reqs-1:0] grants, // (one-hot) 1 indicates req won grant
  output logic                  kout    // kill out
);

  // The internal kills signals essentially form a kill chain from the
  // highest priority to the lowest priority requester. The highest
  // priority requster (say requester i) which is actually making a
  // request sets the kill signal for the next requester to one (ie
  // kills[i+1]) and then this kill signal is propagated to all lower
  // priority requesters.

  logic [p_num_reqs:0] kills;
  assign kills[0] = 1'b0;

  // The per requester logic first computes the grant signal and then
  // computes the kill signal for the next requester.

  logic [p_num_reqs-1:0] grants_int;

  genvar i;
  generate
  for ( i = 0; i < p_num_reqs; i = i + 1 )
  begin : per_req_logic

    // Grant is true if this requester is not killed and it is actually
    // making a req.

    assign grants_int[i] = !kills[i] && reqs[i];

    // Kill is true if this requester was either killed or it received
    // the grant.

    assign kills[i+1] = kills[i] || grants_int[i];

  end
  endgenerate

  // We AND kin into the grant and kout signals afterwards so that we can
  // begin doing the arbitration before we know kin. This also allows us
  // to build hybrid tree-ripple arbiters out of vc_FixedArbChain
  // components.

  assign grants = grants_int & {p_num_reqs{~kin}};
  assign kout   = kills[p_num_reqs] || kin;

endmodule
