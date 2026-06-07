module repeat_event_example (
  input clk,
  input rst_n,
  input start_pulse,
  output reg [3:0] counter_out
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter_out <= 4'b0;
    end else if (start_pulse) begin
      repeat (4) @(posedge clk); // Non-synthesizable 'repeat event' expression
      counter_out <= counter_out + 1;
    end
  end

endmodule
