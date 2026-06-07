module curve_w218_20260111_071226_attempt4 (
    input [1:0]  multibit_event_sig_w218, // Multibit signal to trigger W218
    output reg   output_from_w218_block // Output driven by the W218 violating block
);

  // W218 trigger: Edge specification should not be used for a multibit expression.
  // This 'always' block uses a multibit input signal in its event control with 'posedge'.
  // This is the direct and minimal way to trigger W218 in a synthesizable context.
  // The block contains a synthesizable action (non-blocking assignment to a 'reg')
  // to ensure it is analyzed in a synthesis-relevant flow and not ignored (unlike 'initial' blocks).
  always @(posedge multibit_event_sig_w218) begin // This line targets W218
    output_from_w218_block <= 1'b1; // Perform a minimal synthesizable action
  end

endmodule
