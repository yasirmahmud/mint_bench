module curve_synth_78_20260111_194547_400036_w36056_attempt9 (
  input wire clk,
  input wire reset,
  input wire condition,
  output reg data_out
);

  // This 'always' block demonstrates a non-synthesizable 'wait' construct
  // within a synchronous context. While the rest of the block would infer
  // flip-flops, the 'wait' statement is ignored by synthesis tools.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      data_out <= 1'b0;
    } else begin
      if (condition) begin
        // SYNTH_78 violation: 'wait' construct was not synthesizable.
        // As described, synthesis tools ignore the 'wait' line and proceed
        // as if `data_out <= 1'b1;` is executed immediately when `condition` is true.
        // Removing the non-synthesizable 'wait (data_in);' construct preserves
        // the described *synthesized* functional behavior.
        data_out <= 1'b1;
      end else begin
        data_out <= 1'b0;
      end
    }
  end

endmodule
