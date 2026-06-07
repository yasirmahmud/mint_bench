module curve_synth_5288_20260110_180940_attempt11 (
  input wire clk,
  input wire in_data,
  output reg out_data
);

  // A simple D-flip-flop to ensure basic synthesizable logic is present
  // and all declared inputs/outputs are used, avoiding unused signal warnings.
  always @(posedge clk) begin
    out_data <= in_data;
  end

  // Declare a Verilog-2001 event variable.
  event my_event;

  // This 'always' block is sensitive to the declared event.
  // Using an 'event' in a sensitivity list is considered unsynthesizable,
  // triggering the SYNTH_5288 rule.
  // A $display statement is included to make the block non-empty,
  // which can prevent certain tool crashes or unexpected behavior
  // observed in previous attempts with entirely empty event-sensitive blocks.
  always @(my_event) begin
    $display("Verilog event 'my_event' triggered. This is unsynthesizable.");
  end

endmodule
