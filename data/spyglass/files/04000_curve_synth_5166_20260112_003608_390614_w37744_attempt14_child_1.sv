module curve_synth_5166_20260112_003608_390614_w37744_attempt14 (
  input wire clk,
  input wire rst_n,
  input wire load_en,
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  reg [7:0] data_reg;

  // SYNTH_5166 violations: $display statements are not synthesizable.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_reg <= 8'h00;
      data_out <= 8'h00;
    end else if (load_en) begin
      data_reg <= data_in;
      data_out <= data_in; // Output reflects current input
    end else begin
      // Hold the current registered value if not enabled, preventing latch inference
      data_out <= data_reg;
    }
  end

endmodule
