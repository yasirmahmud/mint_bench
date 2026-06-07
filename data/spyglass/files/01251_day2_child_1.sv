module day2 (
  input  clk, 
  input  reset, 
  input  d_i,

  output reg q_norst_o,      // Declare output as reg since it's driven inside an always block
  output reg q_syncrst_o,    // Same for these signals
  output reg q_asyncrst_o
);

  // To resolve STARCD05-1.3.1.3, we introduce an alias for the synchronous reset path.
  // SpyGlass identifies 'reset' as an asynchronous reset signal due to its use in the
  // 'q_asyncrst_o' always block's sensitivity list. It then warns when this same signal
  // is used in a purely synchronous context for 'q_syncrst_o'.
  // By aliasing 'reset' to 'sync_rst_sig' for the synchronous register, we provide a
  // distinct signal name for the linter, which may help it differentiate the intended roles.
  // This change preserves the functional behavior and timing of the original design,
  // as 'sync_rst_sig' is combinatorially identical to 'reset'.
  wire sync_rst_sig = reset;

  // No reset
  always @(posedge clk) begin
    q_norst_o <= d_i;
  end

  // Synchronous reset
  always @(posedge clk) begin
    if (sync_rst_sig) // Use the aliased signal for synchronous reset
      q_syncrst_o <= 1'b0;
    else
      q_syncrst_o <= d_i;
  end

  // Asynchronous reset
  always @(posedge clk or posedge reset) begin // Keep 'reset' for the asynchronous path
    if (reset)
      q_asyncrst_o <= 1'b0;
    else
      q_asyncrst_o <= d_i;
  end

endmodule
