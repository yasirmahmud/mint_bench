module curve_synth_5166_20260111_220415_199451_w49296_attempt11 (
  input wire clk,
  input wire rst_n,
  input wire en,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // This block describes a simple 8-bit register with asynchronous reset and synchronous enable.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
      // SYNTH_5166 violation #1: The $display statement is not synthesizable.
      $display("[%0t] Module reset: data_out cleared to %h.", $time, data_out);
    end else if (en) begin
      data_out <= data_in;
      // SYNTH_5166 violation #2: The $display statement is not synthesizable.
      $display("[%0t] Data update: data_out set to %h from input %h.", $time, data_in, data_in);
    end else begin
      // Hold current value when not enabled to prevent latch inference
      data_out <= data_out;
    end
  end

endmodule
