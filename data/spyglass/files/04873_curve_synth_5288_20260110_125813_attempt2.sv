module curve_synth_5288_20260110_125813_attempt2 (
  input clk,
  input rst_n
);

  // Declare an event type variable.
  event my_event;

  // A local register. It is driven only by the unsynthesizable 'always @(my_event)' block.
  // When SYNTH_5288 triggers and this block is ignored for synthesis, 'my_local_reg'
  // will effectively be an undriven internal signal, which is generally not flagged as an error.
  reg my_local_reg; // Declared for usage within the unsynthesizable block.

  // This 'always' block is sensitive to an 'event' variable.
  // This is the direct cause of the SYNTH_5288 violation.
  // This block is expected to be flagged as unsynthesizable. Its contents (e.g., assignment to my_local_reg)
  // should not lead to further synthesis violations because the block itself is ignored.
  always @(my_event) begin // This line is expected to trigger SYNTH_5288
    my_local_reg = ~my_local_reg; // Dummy operation for simulation, no synthesis impact.
  end

  // A minimal synthesizable block to ensure the module is not entirely empty of synthesizable logic.
  // This block operates independently and does not interact with 'my_event' or 'my_local_reg',
  // thus avoiding unintended interactions or additional rule violations.
  reg [7:0] synthesizable_counter;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      synthesizable_counter <= 8'h00;
    end else begin
      synthesizable_counter <= synthesizable_counter + 8'h01;
    end
  end

endmodule
