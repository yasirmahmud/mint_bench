module vc_VariableArbChain
#(
  parameter p_num_reqs = 2
)(
  input  wire                  kin,         // kill in
  input  wire [p_num_reqs-1:0] priority_,   // (one-hot) 1 = high priority req
  input  wire [p_num_reqs-1:0] reqs,        // 1 = making a req, 0 = no req
  output wire [p_num_reqs-1:0] grants,      // (one-hot) 1 is req won grant
  output wire                  kout         // kill out
);

  // Output registers for combinatorial logic
  reg  [p_num_reqs-1:0]   grants_r;
  reg                    kout_r;

  // Current index of the highest priority requester based on the one-hot priority_ input
  integer priority_idx;

  // Combinatorial logic to determine grants and kout
  always @* begin
    // Default to no grants and kill out if no requests are granted
    grants_r = {p_num_reqs{1'b0}};
    kout_r   = 1'b1; // Assume kill unless a grant is issued

    // Determine the priority index from the one-hot vector
    priority_idx = 0;
    // Assuming p_num_reqs is at least 1
    if (p_num_reqs > 0) begin
      for (priority_idx = 0; priority_idx < p_num_reqs; priority_idx = priority_idx + 1) begin
        if (priority_[priority_idx]) begin
          break; // Found the index of the highest priority requester
        end
      end
    end

    // If kill_in is asserted, this arbiter cannot issue a grant
    if (kin) begin
      grants_r = {p_num_reqs{1'b0}};
      kout_r   = 1'b1;
    end else if (p_num_reqs > 0) begin
      // Perform round-robin arbitration starting from priority_idx
      integer current_req_idx;
      integer granted_idx = -1;

      // Iterate through requesters in priority order (starting from priority_idx and wrapping around)
      for (current_req_idx = 0; current_req_idx < p_num_reqs; current_req_idx = current_req_idx + 1) {
        integer actual_req_idx = (priority_idx + current_req_idx) % p_num_reqs;
        if (reqs[actual_req_idx]) begin
          granted_idx = actual_req_idx;
          break; // Grant to the first active requester found in priority order
        end
      }

      if (granted_idx != -1) begin
        // A requester was found and granted
        grants_r[granted_idx] = 1'b1;
        kout_r = 1'b0; // No kill out, as a grant was issued locally
      end else begin
        // No active requesters, no grant issued
        grants_r = {p_num_reqs{1'b0}};
        kout_r = 1'b1; // Propagate kill out, as no grant was issued
      end
    end
  end

  // Assign outputs from the combinatorial logic
  assign grants = grants_r;
  assign kout   = kout_r;

endmodule
