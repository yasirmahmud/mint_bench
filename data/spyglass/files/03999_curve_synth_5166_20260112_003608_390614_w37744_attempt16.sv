module curve_synth_5166_20260112_003608_390614_w37744_attempt16 (
  input wire clk,
  input wire rst_n,
  input wire [3:0] input_data,
  input wire load_en,
  output reg [3:0] output_data
);

  reg [3:0] internal_reg;

  // SYNTH_5166 violation #1: $display statement in a sequential block.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      internal_reg <= 4'h0;
      $display("SYNTH_5166 #1: Module reset detected at %0t", $time); // First violation
    end else if (load_en) begin
      internal_reg <= input_data;
    end
  end

  // SYNTH_5166 violation #2: $display statement in a combinational block.
  always @(*) begin
    output_data = internal_reg; // Drive output combinatorially from the internal register

    if (internal_reg == 4'hF) begin // Trigger display when internal register reaches a specific value
      $display("SYNTH_5166 #2: Internal register reached max value 0x%h at %0t", internal_reg, $time); // Second violation
    end
  end

endmodule
