module curve_synth_5166_20260111_175739_553561_w36056_attempt8 (
  input wire clk,
  input wire rst_n,
  output reg out_toggle
);

  // This always block implements a synthesizable flip-flop with asynchronous reset.
  // The $display statement inside will trigger SYNTH_5166 (first occurrence).
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_toggle <= 1'b0;
      $display("INFO: Reset asserted! Current time: %t", $time); // SYNTH_5166 #1
    end else begin
      out_toggle <= ~out_toggle;
    end
  end

  // This always block includes another $display statement,
  // triggering SYNTH_5166 (second occurrence).
  // The input 'clk' is used in its sensitivity list, preventing W240.
  always @(posedge clk) begin
    if (out_toggle) begin
      $display("DEBUG: Output toggled to HIGH at %t", $time); // SYNTH_5166 #2
    end
  end

endmodule
