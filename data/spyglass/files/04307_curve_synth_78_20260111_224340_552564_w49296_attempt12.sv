module curve_synth_78_20260111_224340_552564_w49296_attempt12 (
  input clk,
  input rst_n,
  input trigger_in,
  input data_ready_sig,
  output reg flag_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      flag_out <= 1'b0;
    end else begin
      // Default assignment to ensure flag_out is always driven and avoids latches.
      flag_out <= 1'b0;

      if (trigger_in) begin
        // In simulation, flag_out would go high, wait for data_ready_sig,
        // then go low. However, the 'wait' construct is not synthesizable.
        // Synthesis tools will ignore 'wait (data_ready_sig);'.
        // Consequently, if 'trigger_in' is high, the sequence 'flag_out <= 1'b1;' 
        // followed by 'flag_out <= 1'b0;' will execute immediately, 
        // resulting in flag_out being 1'b0 in the next clock cycle if 'trigger_in' is asserted.
        flag_out <= 1'b1; // This assignment will be immediately overridden by the subsequent one in synthesis.
        wait (data_ready_sig); // SYNTH_78 violation: 'wait' construct is not synthesizable
        flag_out <= 1'b0;
      end
    end
  end

endmodule
