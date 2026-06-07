module curve_synth_78_20260111_224340_552564_w49296_attempt11 (
  input enable,
  input condition_in,
  output reg output_data
);

  always @* begin
    output_data = 1'b0; // Default assignment to avoid latch
    if (enable) begin
      // The 'wait' construct is not synthesizable and will be ignored by synthesis tools.
      // 'output_data = 1'b1;' will be synthesized to execute immediately when 'enable' is high,
      // effectively ignoring the 'wait' condition.
      wait (enable && condition_in); // SYNTH_78 violation: 'wait' construct is not synthesizable
      output_data = 1'b1;
    end
  end

endmodule
