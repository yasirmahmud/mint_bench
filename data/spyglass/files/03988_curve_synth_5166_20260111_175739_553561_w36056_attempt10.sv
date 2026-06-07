module curve_synth_5166_20260111_175739_553561_w36056_attempt10 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] data_out
);

  reg [7:0] counter;

  // This always block describes a synthesizable counter.
  // The $display statement inside will trigger the SYNTH_5166 violation.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 8'h00;
      data_out <= 8'h00;
    end else begin
      counter <= counter + 8'h01;
      data_out <= counter;

      // SYNTH_5166 violation: ($display) Statement is not synthesizable.
      $display("Counter value: %d at time %t", counter, $time);
    end
  end

endmodule
