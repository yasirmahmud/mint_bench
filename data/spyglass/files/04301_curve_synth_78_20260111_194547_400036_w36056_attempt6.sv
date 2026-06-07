module curve_synth_78_20260111_194547_400036_w36056_attempt6 (
  input wire clk,
  input wire rst_n,
  input wire start_signal,
  output reg busy_flag
);

  // This 'always' block demonstrates a non-synthesizable 'wait' construct.
  // The 'wait' statement causes a SYNTH_78 violation because it implies a
  // dynamic pause in execution until a condition is met, which cannot be
  // translated into static hardware logic for synthesis.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      busy_flag <= 1'b0;
    end else begin
      if (start_signal) begin
        busy_flag <= 1'b1;
        // SYNTH_78 violation: 'wait' construct is not synthesizable.
        // This attempts to hold the process until start_signal goes low,
        // which has no direct hardware equivalent for synthesis and will be ignored.
        wait (start_signal == 1'b0);
        busy_flag <= 1'b0;
      end else begin
        busy_flag <= 1'b0;
      end
    end
  end

endmodule
