module curve_synth_5188_20260111_214913_690404_w49296_attempt17 (
    input wire sys_clk,
    input wire async_reset_n,
    input wire enable_signal,
    input wire [1:0] input_data,
    output reg [1:0] output_reg
);

  // This module contains an asynchronous always block with an
  // event control statement on the RHS of an assignment.
  // This pattern is explicitly shown in the context examples for SYNTH_5188.
  always @(posedge sys_clk or negedge async_reset_n) begin
    if (!async_reset_n) begin
      output_reg <= 2'b0;
    end else if (enable_signal) begin
      // SYNTH_5188 violation: Invalid placement of event control statement
      // inside an asynchronous implicit style always block.
      output_reg <= @(posedge sys_clk) input_data;
    end else begin
      output_reg <= 2'b1;
    end
  end

endmodule
