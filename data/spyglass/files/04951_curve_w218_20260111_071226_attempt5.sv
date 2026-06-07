module curve_w218_20260111_071226_attempt5 (
    input clk,
    input rst_n,
    input [1:0] multibit_event_sig_w218, // Multibit signal to trigger W218
    output reg data_out // Synthesizable output to ensure module analysis
);

  // A minimal synthesizable block to ensure the module is considered synthesizable
  // and avoids other general synthesis errors (e.g., ErrorAnalyzeBBox for unsynthesizable DU).
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      data_out <= 1'b1; // Dummy operation
    end
  end

  // W218 trigger: Edge specification should not be used for a multibit expression.
  // By placing the violation within an 'initial' block and using 'wait (posedge ...)',
  // we aim to trigger W218 (a semantic rule) while avoiding SYNTH_5405.
  // 'initial' blocks are typically ignored by synthesis, thus preventing the multibit signal
  // from being interpreted as a clock for a synthesizable element, which is what triggers SYNTH_5405.
  initial begin
    wait (posedge multibit_event_sig_w218); // This line targets W218
    // Add a minimal simulation action to make the 'wait' clause meaningful, though this part is non-synthesizable.
    $display("W218 event detected on multibit signal (simulation context)");
  end

endmodule
