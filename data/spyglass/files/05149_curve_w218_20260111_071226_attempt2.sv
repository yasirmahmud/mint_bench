module curve_w218_20260111_071226_attempt2 (
    input        clk,
    input [1:0]  multibit_event_sig,
    input        data_in,
    output reg   data_out
);

  // Synthesizable logic to ensure the module is valid and avoids 'UnsynthesizedDU' issues.
  always @(posedge clk) begin
    data_out <= data_in;
  end

  // W218 trigger: Edge specification should not be used for a multibit expression.
  // This block is intentionally made non-synthesizable (by using $display)
  // to prevent synthesis-related errors (like SYNTH_5405) that would arise if
  // 'multibit_event_sig' were interpreted as a clock for a synthesizable element.
  always @(posedge multibit_event_sig) begin
    $display("W218 violation detected: Multibit signal edge used at time %t", $time);
  end

endmodule
