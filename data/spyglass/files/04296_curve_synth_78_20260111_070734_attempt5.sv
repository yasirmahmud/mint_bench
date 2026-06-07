module curve_synth_78_20260111_070734_attempt5 (
  input wire clk,
  input wire rst_n,
  input wire trigger_in,
  output reg data_out
);

  // The 'wait' construct is not synthesizable and directly triggers SYNTH_78.
  // This construct tells the simulator to pause execution until the condition is met.
  // In synthesizable RTL, sensitivity lists or explicit state machines are used instead.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 1'b0;
    end else begin
      wait (trigger_in == 1'b1); // SYNTH_78: 'wait' construct is not synthesizable.
      data_out <= 1'b1;
    end
  end

endmodule
