module curve_synth_132_20260111_222741_754713_w15680_attempt11 (
  input wire clk,
  input wire rst_n,
  input wire start_signal,
  output wire done_signal
);

  wire done_signal_internal;

  // Instantiate the sub_module
  sub_module #(.DATA_WIDTH(10)) u_param_source (
    .clk      (clk),
    .rst_n    (rst_n),
    .data_in  (start_signal),
    .data_out (done_signal_internal)
  );

  // SYNTH_132 Violation: Hierarchical references to module parameters
  // are not supported for synthesis when used in constant expressions.
  localparam MAX_COUNT_VALUE = u_param_source.DATA_WIDTH + 5; // Triggers SYNTH_132

  reg [MAX_COUNT_VALUE-1:0] counter;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= {MAX_COUNT_VALUE{1'b0}};
    end else if (start_signal) begin
      counter <= counter + 1;
    end
  end

  assign done_signal = done_signal_internal;

endmodule
