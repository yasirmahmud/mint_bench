module curve_synth_78_20260111_194547_400036_w36056_attempt7 (
  input wire clk,
  input wire rst_n,
  input wire enable_condition,
  output reg output_data
);

  // This 'always' block demonstrates a non-synthesizable 'wait' construct.
  // The 'wait' statement causes a SYNTH_78 violation because it implies a
  // dynamic pause in execution until a condition is met, which cannot be
  // translated into static hardware logic for synthesis.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      output_data <= 1'b0;
    end else begin
      if (enable_condition) begin
        // SYNTH_78 violation: 'wait' construct is not synthesizable.
        // This statement attempts to hold the process until 'enable_condition' goes low.
        // For synthesis, this construct is ignored, but its presence triggers the warning.
        wait (enable_condition == 1'b0);
        output_data <= 1'b1; // This assignment will be synthesized, as the 'wait' is ignored.
      end else begin
        output_data <= 1'b0;
      end
    end
  end

endmodule
