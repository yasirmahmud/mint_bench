module curve_synth_5166_20260112_003608_390614_w37744_attempt15 (
  input wire clk,
  input wire rst_n,
  input wire enable_i,
  input wire [7:0] data_in_i,
  output reg [7:0] data_out_o
);

  reg [7:0] current_value;

  // SYNTH_5166 violations: $display statements are not synthesizable.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_value <= 8'h00;
      data_out_o <= 8'h00;
      $display("SYNTH_5166 #1: Reset detected! Initializing internal state at %t.", $time); // First violation
    end else if (enable_i) begin
      current_value <= data_in_i;
      data_out_o <= data_in_i;
      if (data_in_i == 8'hAA) begin // Specific condition for second violation
        $display("SYNTH_5166 #2: Data 0xAA loaded. Timestamp: %t.", $time); // Second violation
      end
    end else begin
      // Hold current value for data_out_o when not enabled to prevent latch inference
      data_out_o <= current_value;
    end
  end

endmodule
