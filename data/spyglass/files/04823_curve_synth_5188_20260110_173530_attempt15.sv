module curve_synth_5188_20260110_173530_attempt15 (
  input clk,
  input reset_n,
  input [3:0] data_in_bus,
  output reg [3:0] data_out_bus
);

  // Target rule: SYNTH_5188
  // Invalid placement of event control statement inside asynchronous implicit style always block.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      data_out_bus <= 4'b0;
    end else begin
      // This line triggers SYNTH_5188: event control on RHS of assignment
      // within an asynchronous always block.
      data_out_bus <= @(posedge clk) data_in_bus;
    end
  end

endmodule
