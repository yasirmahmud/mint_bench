module curve_synth_78_20260111_070734_attempt2 (
  input wire clk_i,
  input wire rst_ni,
  input wire start_i,
  output reg done_o
);

  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      done_o <= 1'b0;
    end else if (start_i) begin
      // SYNTH_78: 'wait' construct is not synthesizable. Ignoring for synthesis
      wait (start_i == 1'b0); // This 'wait' construct will trigger SYNTH_78
      done_o <= 1'b1;
    end else begin
      done_o <= 1'b0;
    end
  end

endmodule
