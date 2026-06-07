module curve_synth_5288_20260110_180940_attempt6 (
  input wire clk,
  input wire rst_n,
  input wire enable,
  output wire out_reg
);

  // Declare an event
  event my_event;

  // This always block using 'my_event' should trigger SYNTH_5288
  // Usage of 'event' in an always construct is not synthesizable.
  always @(my_event) begin
    $display("my_event triggered!");
  end

  // Minimal synthesizable logic to use inputs and drive outputs
  // and prevent other common warnings (unused signals, etc.)
  reg internal_reg;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_reg <= 1'b0;
    end else begin
      internal_reg <= enable;
    end
  end

  assign out_reg = internal_reg; // Drive output with synthesizable logic

endmodule
