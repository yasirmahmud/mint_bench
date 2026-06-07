module curve_starc05_1_2_1_2_20260111_193735_888802_w7792_attempt8 (
  input wire [31:0] s_in,     // Active-low set input
  input wire [31:0] r_in,     // Active-low reset input
  output wire [31:0] q_out,
  output wire [31:0] qn_out
);

  localparam WIDTH = 32;

  // Internal registers for the latch outputs
  // Changed from 'wire' to 'reg' because they are driven by 'always' blocks.
  reg [WIDTH-1:0] q_internal;

  generate
    genvar i;
    for (i = 0; i < WIDTH; i = i + 1) begin : rs_latch_cell
      // STARC05-1.2.1.2 violation: RS Latch inferred using primitive cells.
      // CombLoop violation: Combinational loop exists due to cross-coupled gates.
      // To resolve these violations, the RS latch is re-implemented using a behavioral
      // 'always @(*)' block, which is the standard synthesizable way to infer a latch.
      // This explicitly describes the level-sensitive behavior, allowing synthesis tools
      // to map it to a library latch cell without inferring undesirable combinational loops.
      // The 's_in=0, r_in=0' (forbidden) state is resolved by giving priority to 's_in=0' (Set).
      always @(s_in[i] or r_in[i]) begin
        if (s_in[i] == 1'b0) begin     // Active-low Set takes precedence
          q_internal[i] = 1'b1;
        end else if (r_in[i] == 1'b0) begin // Active-low Reset
          q_internal[i] = 1'b0;
        end
        // Else (s_in[i]=1 and r_in[i]=1), q_internal[i] holds its previous value (latch behavior)
      end
    end
  endgenerate

  // Assign internal latch outputs to module outputs
  assign q_out = q_internal;
  // The qn_out is now explicitly the logical inverse of q_out, as expected for a well-formed latch.
  assign qn_out = ~q_internal;

endmodule
