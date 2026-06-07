// This module implements a variable priority arbiter chain.
// It takes a one-hot priority vector to determine the starting point
// for a round-robin arbitration scheme.
// `kin` allows chaining arbiters; `1` means a higher priority arbiter granted,
// preventing this one from granting.
// `kout` indicates if this arbiter granted a request.
module vc_VariableArbChain #(
  parameter p_num_reqs = 2
)
(
  input                  kin,       // Carry-in (1 if higher priority granted, 0 otherwise)
  input  [p_num_reqs-1:0] priority_, // One-hot priority vector (indicates highest priority request)
  input  [p_num_reqs-1:0] reqs,      // Request vector
  output [p_num_reqs-1:0] grants,    // One-hot grant vector
  output                 kout       // Carry-out (1 if this arbiter granted)
);

  // Determine the index of the highest priority request from the one-hot priority_ vector.
  // $clog2 requires p_num_reqs > 1; handle p_num_reqs=1 as a special case.
  localparam L_PRIORITY_IDX_WIDTH = (p_num_reqs > 1) ? $clog2(p_num_reqs) : 1;
  wire [L_PRIORITY_IDX_WIDTH-1:0] priority_idx_val_wire;

  generate
    if (p_num_reqs == 1) begin : single_req_priority_idx_g
      assign priority_idx_val_wire = 0;
    end else begin : multi_req_priority_idx_g
      reg [L_PRIORITY_IDX_WIDTH-1:0] priority_idx_reg_local;
      genvar pi;
      always_comb begin
          priority_idx_reg_local = 0; // Default if priority_ is all zeros (should not happen for one-hot)
          for (pi = 0; pi < p_num_reqs; pi = pi + 1) begin
            if (priority_[pi]) begin
              priority_idx_reg_local = pi;
              break; // SystemVerilog 'break' is synthesizable in always_comb
            end
          end
      end
      assign priority_idx_val_wire = priority_idx_reg_local;
    end
  endgenerate

  // Rotate requests based on the current priority index.
  // `priority_reqs[0]` gets `reqs[priority_idx_val_wire]` (highest priority request).
  wire [p_num_reqs-1:0] priority_reqs;
  genvar idx;
  generate
    for (idx = 0; idx < p_num_reqs; idx++) begin : rotate_reqs_g
      assign priority_reqs[idx] = reqs[(priority_idx_val_wire + idx) % p_num_reqs];
    end
  endgenerate

  // Fixed priority encoder on the rotated requests.
  // `fixed_priority_grants[0]` is for `priority_reqs[0]`, etc.
  wire [p_num_reqs-1:0] fixed_priority_grants;
  genvar f_idx;
  generate
    for (f_idx = 0; f_idx < p_num_reqs; f_idx++) begin : fixed_prio_enc_g
      if (f_idx == 0) begin
        assign fixed_priority_grants[f_idx] = priority_reqs[f_idx];
      end else begin
        // Grant if this request is active AND no higher priority request
        // (in the rotated view) was active.
        assign fixed_priority_grants[f_idx] = priority_reqs[f_idx] & ~prior_req_active_in_rotated[f_idx-1];
      end
    end
  endgenerate

  // Helper to check if any higher priority request was active in the rotated view.
  wire [p_num_reqs-1:0] prior_req_active_in_rotated;
  genvar r_idx;
  generate
    for (r_idx = 0; r_idx < p_num_reqs; r_idx++) begin : prior_req_active_g
      if (r_idx == 0) begin
        assign prior_req_active_in_rotated[r_idx] = 1'b0; // No prior request for the first one
      end else begin
        assign prior_req_active_in_rotated[r_idx] = |priority_reqs[r_idx-1:0];
      end
    end
  endgenerate

  // Rotate the grants back to their original indices.
  wire [p_num_reqs-1:0] grants_unconditional; // Grants before considering 'kin'
  genvar g_idx;
  generate
    for (g_idx = 0; g_idx < p_num_reqs; g_idx++) begin : rotate_grants_back_g
      // `fixed_priority_grants[j]` corresponds to `reqs[(priority_idx_val_wire + j) % p_num_reqs]`.
      // So, `grants[(priority_idx_val_wire + j) % p_num_reqs]` gets `fixed_priority_grants[j]`.
      assign grants_unconditional[(priority_idx_val_wire + g_idx) % p_num_reqs] = fixed_priority_grants[g_idx];
    end
  endgenerate

  // Final grants output: if kin is asserted, no local grant.
  assign grants = kin ? {p_num_reqs{1'b0}} : grants_unconditional;
  // Kout output: true if this arbiter granted (and kin was 0).
  assign kout = kin ? 1'b0 : (|grants_unconditional);

endmodule
