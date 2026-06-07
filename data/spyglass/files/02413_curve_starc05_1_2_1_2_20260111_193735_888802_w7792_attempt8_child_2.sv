module curve_starc05_1_2_1_2_20260111_193735_888802_w7792_attempt8 (
  input wire clk,             // Added clock input to resolve InferLatch violation
  input wire [31:0] s_in,     // Active-low set input
  input wire [31:0] r_in,     // Active-low reset input
  output wire [31:0] q_out,
  output wire [31:0] qn_out
);

  localparam WIDTH = 32;

  // Internal registers for the flip-flop outputs
  // Changed from 'wire' to 'reg' because they are driven by 'always' blocks.
  reg [WIDTH-1:0] q_internal;

  generate
    genvar i;
    for (i = 0; i < WIDTH; i = i + 1) begin : sr_ff_cell
      // STARC05-1.2.1.2 violation: RS Latch inferred using primitive cells. (Previous issue)
      // CombLoop violation: Combinational loop exists due to cross-coupled gates. (Previous issue)
      // The previous attempt re-implemented the RS latch using a behavioral 'always @(*)' block.
      // However, the current SpyGlass "InferLatch" violation indicates that inferred latches
      // are not permitted. To resolve this violation while preserving the set/reset/hold
      // functional behavior, the design is converted to a synchronous RS flip-flop.
      // This requires the addition of a clock input.
      // The 's_in=0, r_in=0' (forbidden) state is still resolved by giving priority to 's_in=0' (Set).
      always @(posedge clk) begin
        if (s_in[i] == 1'b0) begin     // Active-low Set takes precedence (synchronous)
          q_internal[i] = 1'b1;
        end else if (r_in[i] == 1'b0) begin // Active-low Reset (synchronous)
          q_internal[i] = 1'b0;
        end
        // Else (s_in[i]=1 and r_in[i]=1), q_internal[i] holds its previous value on the clock edge
        // (synchronous flip-flop behavior, as no other assignment occurs).
      end
    end
  endgenerate

  // Assign internal flip-flop outputs to module outputs
  assign q_out = q_internal;
  // The qn_out is now explicitly the logical inverse of q_out, as expected for a well-formed flip-flop.
  assign qn_out = ~q_internal;

endmodule
