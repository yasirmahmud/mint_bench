module curve_synth_78_20260111_194547_400036_w36056_attempt9 (
  input wire clk,
  input wire reset,
  input wire condition,
  input wire data_in,
  output reg data_out
);

  // This 'always' block demonstrates a non-synthesizable 'wait' construct
  // within a synchronous context. While the rest of the block would infer
  // flip-flops, the 'wait' statement is ignored by synthesis tools.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      data_out <= 1'b0;
    end else begin
      if (condition) begin
        // SYNTH_78 violation: 'wait' construct is not synthesizable.
        // Synthesis tools will ignore this line and proceed as if it were not present,
        // causing `data_out <= 1'b1;` to be executed immediately when `condition` is true.
        wait (data_in); 
        data_out <= 1'b1;
      end else begin
        data_out <= 1'b0;
      end
    end
  end

endmodule
