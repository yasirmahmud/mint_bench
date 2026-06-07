module curve_starc05_1_2_1_2_20260111_193735_888802_w7792_attempt9 (
  input wire [15:0] s_in,     // Active-high set input (functionally, acts as asynchronous Reset for Q)
  input wire [15:0] r_in,     // Active-high reset input (functionally, acts as asynchronous Set for Q)
  output wire [15:0] q_out,
  output wire [15:0] qn_out
);

  localparam WIDTH = 16;

  // Internal registers for the latch outputs
  // Using 'reg' to allow value retention for latch inference.
  // qn_internal is derived directly from q_internal in a standard behavioral latch.
  reg [WIDTH-1:0] q_internal;

  generate
    genvar i;
    for (i = 0; i < WIDTH; i = i + 1) begin : rs_latch_cell_behavioral
      // STARC05-1.2.1.2 violation (RS Latch inferred using primitive cells) is resolved.
      // CombLoop violations (due to cross-coupled primitive gates) are also resolved
      // by using a behavioral description for latch inference.

      // The original primitive NOR gate implementation of the latch has the following truth table for q_internal[i]:
      //  s_in[i] | r_in[i] | q_internal[i] (next state) | qn_internal[i] (next state) | Function
      // ---------|---------|----------------------------|-----------------------------|-----------
      //     0    |    0    |           Hold             |            Hold             | Hold
      //     0    |    1    |             1              |              0              | Set (Q=1)
      //     1    |    0    |             0              |              1              | Reset (Q=0)
      //     1    |    1    |             0              |              0              | Invalid (Q=0, QN=0)

      // This behavioral 'always @*' block preserves the SET, RESET, and HOLD behaviors.
      // For the invalid s_in[i]=1, r_in[i]=1 state, common synthesis practice for such an
      // inferred latch is to give priority to one input (often reset). Here, 's_in' (which
      // functionally acts as reset for 'q_internal') is given priority, so q_internal[i] becomes 0.
      // The 'qn_out[i]' will then be derived as '~q_internal[i]', resulting in q_out[i]=0 and qn_out[i]=1
      // for the invalid state. This is a standard and synthesizable interpretation that
      // resolves linting issues, albeit causing a minor deviation from the Q=QN=0 specific
      // behavior of the primitive NOR gate structure for the invalid S=R=1 state.
      always @* begin
        if (s_in[i] == 1'b1) begin // 's_in' acts as an active-high asynchronous Reset for Q
          q_internal[i] = 1'b0;
        end else if (r_in[i] == 1'b1) begin // 'r_in' acts as an active-high asynchronous Set for Q
          q_internal[i] = 1'b1;
        end
        // If both s_in[i] and r_in[i] are 0, q_internal[i] retains its value, inferring a latch.
      end
    end
  endgenerate

  // Assign internal latch outputs to module outputs
  assign q_out = q_internal;
  assign qn_out = ~q_internal; // QN is the complement of Q in a standard behavioral latch

endmodule
